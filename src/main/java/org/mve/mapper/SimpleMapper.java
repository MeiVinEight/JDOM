package org.mve.mapper;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mve.invoke.ConstructorAccessor;
import org.mve.invoke.FieldAccessor;
import org.mve.invoke.MagicAccessor;
import org.mve.invoke.ReflectionFactory;
import org.mve.invoke.common.JavaVM;
import org.mve.query.Query;

import javax.persistence.Column;
import javax.persistence.Table;
import javax.sql.DataSource;
import java.io.Serializable;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class SimpleMapper<T> implements Mapper<T>
{
	private static final Log logger = LogFactory.getLog(SimpleMapper.class);
	private final Class<T> type;
	private final DataSource source;

	public SimpleMapper(Class<T> type, DataSource source)
	{
		this.type = type;
		this.source = source;
	}

	@Override
	public boolean insert(T o)
	{
		Class<?> clazz = o.getClass();
		String tableName = o.getClass().getSimpleName();
		Table tableAnno = clazz.getAnnotation(Table.class);
		if (tableAnno != null) tableName = tableAnno.name();

		try (Connection conn = this.connection())
		{
			StringBuilder sql = new StringBuilder("INSERT INTO ").append(tableName).append(' ');
			StringBuilder columnBuilder = new StringBuilder("(");
			StringBuilder valuesBuilder = new StringBuilder("(");
			Field[] fields = Arrays.stream(MagicAccessor.accessor.getFields(clazz))
				.filter(x -> (x.getModifiers() & Modifier.STATIC) == 0)
				.toArray(Field[]::new);
			for (int i = 0; i < fields.length; i++)
			{
				Field field = fields[i];
				String columnName = field.getName();
				Column columnAnno = field.getAnnotation(Column.class);
				if (columnAnno != null) columnName = columnAnno.name();
				if (i > 0)
				{
					columnBuilder.append(", ");
					valuesBuilder.append(", ");
				}
				columnBuilder.append(columnName);
				valuesBuilder.append('?');
			}
			columnBuilder.append(')');
			valuesBuilder.append(')');
			sql.append(columnBuilder).append(" VALUES ").append(valuesBuilder).append(';');
			SimpleMapper.logger.info(sql.toString());

			try (PreparedStatement stmt = conn.prepareStatement(sql.toString()))
			{
				for (int i = 0; i < fields.length; i++)
				{
					Field field = fields[i];
					FieldAccessor<?> facc = ReflectionFactory.access(field);
					stmt.setObject(i + 1, facc.get(o));
				}
				int x = stmt.executeUpdate();
				return x > 0;
			}
		}
		catch (SQLException t)
		{
			SimpleMapper.logger.error(t);
		}
		return false;
	}

	public T primary(Serializable s)
	{
		String tableName = this.type.getSimpleName();
		Table tableAnno = this.type.getAnnotation(Table.class);
		if (tableAnno != null)
		{
			tableName = tableAnno.name();
		}
		T t = null;
		try (Connection conn = this.connection())
		{
			Set<String> primKeys = this.primaryKey(tableName);
			String sql = "SELECT * FROM " + tableName + " WHERE " + primKeys.iterator().next() + " = ?;";
			SimpleMapper.logger.info(sql);

			try (PreparedStatement stmt = conn.prepareStatement(sql))
			{
				stmt.setObject(1, s);
				try (ResultSet rs = stmt.executeQuery())
				{
					if (rs.next())
					{
						t = this.convert(rs);
					}
				}
			}
		}
		catch (Throwable exce)
		{
			SimpleMapper.logger.error(exce);
		}
		return t;
	}

	@Override
	public T primary(T o)
	{
		Class<?> clazz = o.getClass();
		String tableName = o.getClass().getSimpleName();
		Table tableAnno = clazz.getAnnotation(Table.class);
		if (tableAnno != null)
		{
			tableName = tableAnno.name();
		}
		T t = null;
		try (Connection conn = this.connection())
		{
			Set<String> primKeys = this.primaryKey(tableName);

			Field[] fields = Arrays.stream(MagicAccessor.accessor.getFields(clazz))
				.filter(x -> (x.getModifiers() & Modifier.STATIC) == 0)
				.toArray(Field[]::new);
			List<FieldAccessor<?>> primaryKeys = new LinkedList<>();
			StringBuilder sql = new StringBuilder("SELECT * FROM " + tableName + " WHERE ");

			for (Field field : fields)
			{
				String columnName = field.getName();
				Column column = field.getAnnotation(Column.class);
				if (column != null) columnName = column.name();

				if (primKeys.contains(columnName))
				{
					if (!primaryKeys.isEmpty())
					{
						sql.append(" AND ");
					}
					primaryKeys.add(ReflectionFactory.access(field));
					sql.append(columnName)
						.append(" = ?");
				}
			}
			sql.append(';');
			SimpleMapper.logger.info(sql.toString());

			try (PreparedStatement stmt = conn.prepareStatement(sql.toString()))
			{
				// for (FieldAccessor<?> facc : primaryKeys)
				for (int i = 0; i < primaryKeys.size(); i++)
				{
					FieldAccessor<?> facc = primaryKeys.get(i);
					stmt.setObject(i + 1, facc.get(o));
				}

				try (ResultSet rs = stmt.executeQuery())
				{
					if (rs.next())
					{
						Constructor<T> noArg = MagicAccessor.accessor.getConstructor(clazz);
						if (noArg == null) throw new NullPointerException("No argument constructor not found for " + clazz);
						ConstructorAccessor<T> ctor = ReflectionFactory.access(noArg);
						t = ctor.invoke();
						SimpleMapper.convert(rs, t);
					}
				}
			}

		}
		catch (Throwable exce)
		{
			SimpleMapper.logger.error(exce);
		}
		return t;
	}

	@Override
	public List<T> select(Map<String, Object> where, Class<T> clazz)
	{
		String tableName = clazz.getSimpleName();
		Table tableAnno = clazz.getAnnotation(Table.class);
		if (tableAnno != null) tableName = tableAnno.name();
		List<T> retVal = new LinkedList<>();

		try (Connection conn = this.connection())
		{
			StringBuilder sql = new StringBuilder("SELECT * FROM " + tableName + " WHERE ");
			Object[] args = new Object[where.size()];
			int idx = 0;
			for (String key : where.keySet())
			{
				Object value = where.get(key);
				if (idx > 0) sql.append(" AND ");
				sql.append(key).append(" = ?");
				args[idx++] = value;
			}
			sql.append(';');
			SimpleMapper.logger.info(sql.toString());
			try (PreparedStatement stmt = conn.prepareStatement(sql.toString()))
			{
				for (int i = 0; i < idx; i++)
				{
					stmt.setObject(i + 1, args[i]);
				}

				try (ResultSet rs = stmt.executeQuery())
				{
					while (rs.next())
					{
						retVal.add(this.convert(rs));
					}
				}
			}
		}
		catch (SQLException e)
		{
			SimpleMapper.logger.error(e);
		}
		return retVal;
	}

	public List<T> select(Query query)
	{
		String tableName = this.type.getSimpleName();
		Table tableAnno = this.type.getAnnotation(Table.class);
		if (tableAnno != null) tableName = tableAnno.name();
		List<T> retVal = new LinkedList<>();
		String sql = query.select().from(tableName);
		SimpleMapper.logger.info(sql);

		try (Connection conn = this.connection())
		{
			try (PreparedStatement stmt = conn.prepareStatement(sql))
			{
				query.apply(stmt);
				try (ResultSet rs = stmt.executeQuery())
				{
					while (rs.next())
					{
						retVal.add(this.convert(rs));
					}
				}
			}
		}
		catch (SQLException e)
		{
			SimpleMapper.logger.error(e);
		}
		return retVal;
	}

	@Override
	public boolean update(T o)
	{
		Class<?> clazz = o.getClass();
		String tableName = o.getClass().getSimpleName();
		Table tableAnno = clazz.getAnnotation(Table.class);
		if (tableAnno != null)
		{
			tableName = tableAnno.name();
		}
		try (Connection conn = this.connection())
		{
			StringBuilder sql = new StringBuilder("UPDATE ").append(tableName).append(" SET ");
			StringBuilder where = new StringBuilder(" WHERE ");

			Set<String> primKeys = this.primaryKey(tableName);
			Field[] fields = Arrays.stream(MagicAccessor.accessor.getFields(clazz))
				.filter(x -> (x.getModifiers() & Modifier.STATIC) == 0)
				.toArray(Field[]::new);
			int setCount = 0;
			int whereCount = 0;
			for (Field field : fields)
			{
				String columnName = field.getName();
				Column columnAnno = field.getAnnotation(Column.class);
				if (columnAnno != null) columnName = columnAnno.name();
				if (primKeys.contains(columnName))
				{
					if (whereCount > 0) where.append(" AND ");
					where.append(columnName).append(" = ?");
					whereCount++;
				}
				else
				{
					if (setCount > 0) sql.append(", ");
					sql.append(columnName).append(" = ?");
					setCount++;
				}
			}

			sql.append(where).append(';');
			SimpleMapper.logger.info(sql.toString());
			try (PreparedStatement stmt = conn.prepareStatement(sql.toString()))
			{
				int idxs = 0;
				int idxw = 0;
				for (Field field : fields)
				{
					FieldAccessor<?> accessor = ReflectionFactory.access(field);
					String columnName = field.getName();
					Column columnAnno = field.getAnnotation(Column.class);
					if (columnAnno != null) columnName = columnAnno.name();
					if (primKeys.contains(columnName))
					{
						idxw++;
						stmt.setObject(setCount + idxw, accessor.get(o));
					}
					else
					{
						idxs++;
						stmt.setObject(idxs, accessor.get(o));
					}
				}
				return stmt.executeUpdate() > 0;
			}
		}
		catch (SQLException e)
		{
			SimpleMapper.logger.error(e);
		}
		return false;
	}

	@Override
	public boolean delete(T o)
	{
		Class<?> clazz = o.getClass();
		String tableName = o.getClass().getSimpleName();
		Table tableAnno = clazz.getAnnotation(Table.class);
		if (tableAnno != null)
		{
			tableName = tableAnno.name();
		}
		try (Connection conn = this.connection())
		{
			StringBuilder sql = new StringBuilder("DELETE FROM ").append(tableName).append(" WHERE ");
			Set<String> primKeys = this.primaryKey(tableName);
			Field[] fields = Arrays.stream(MagicAccessor.accessor.getFields(clazz))
				.filter(x -> (x.getModifiers() & Modifier.STATIC) == 0)
				.toArray(Field[]::new);
			List<Object> args = new ArrayList<>(primKeys.size());
			for (Field field : fields)
			{
				String columnName = field.getName();
				Column columnAnno = field.getAnnotation(Column.class);
				if (columnAnno != null) columnName = columnAnno.name();
				if (primKeys.contains(columnName))
				{
					FieldAccessor<?> facc = ReflectionFactory.access(field);
					if (!args.isEmpty()) sql.append(" AND ");
					sql.append(columnName).append(" = ?");
					args.add(facc.get(o));
				}
			}

			sql.append(';');
			SimpleMapper.logger.info(sql.toString());
			try (PreparedStatement stmt = conn.prepareStatement(sql.toString()))
			{
				for (int i = 0; i < args.size(); i++)
				{
					stmt.setObject(i + 1, args.get(i));
				}

				return stmt.executeUpdate() > 0;
			}
		}
		catch (SQLException e)
		{
			SimpleMapper.logger.error(e);
		}
		return false;
	}

	public Set<String> primaryKey(String tableName)
	{
		Set<String> primKeys = new HashSet<>();
		try (Connection conn = this.connection())
		{
			try (ResultSet primKeyRS = conn.getMetaData().getPrimaryKeys(null, null, tableName))
			{
				while (primKeyRS.next())
				{
					primKeys.add(primKeyRS.getString("COLUMN_NAME"));
				}
			}
		}
		catch (SQLException e)
		{
			JavaVM.exception(e);
		}
		return primKeys;
	}

	public T convert(ResultSet rs) throws SQLException
	{
		T t;
		Constructor<T> noArg = MagicAccessor.accessor.getConstructor(this.type);
		if (noArg == null) throw new NullPointerException("No argument constructor not found for " + this.type);
		ConstructorAccessor<T> ctor = ReflectionFactory.access(noArg);
		t = ctor.invoke();
		SimpleMapper.convert(rs, t);
		return t;
	}

	public static <T> void convert(ResultSet rs, T o) throws SQLException
	{
		Field[] fields = Arrays.stream(MagicAccessor.accessor.getFields(o.getClass()))
			.filter(x -> (x.getModifiers() & Modifier.STATIC) == 0)
			.toArray(Field[]::new);
		for (Field field : fields)
		{
			FieldAccessor<?> facc = ReflectionFactory.access(field);
			String columnName = field.getName();
			Column column = field.getAnnotation(Column.class);
			if (column != null) columnName = column.name();
			Class<?> columnType = field.getType();
			try
			{
				facc.set(o, rs.getObject(rs.findColumn(columnName), columnType));
			}
			catch (SQLException ignored)
			{
			}
		}
	}

	public Connection connection() throws SQLException
	{
		return this.source.getConnection();
	}
}
