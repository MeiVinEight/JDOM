package org.mve.query;

import java.sql.PreparedStatement;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

public class Query
{
	private String operator = SQL.SELECT;
	private final List<String> columns = new LinkedList<>();
	private final List<Condition> conditions = new LinkedList<>();

	public Query select()
	{
		this.operator = SQL.SELECT;
		return this;
	}

	public Query select(String... columns)
	{
		this.operator = SQL.SELECT;
		this.columns.clear();
		this.columns.addAll(List.of(columns));
		return this;
	}

	public Query eq(String column, Object value)
	{
		this.conditions.add(new Condition(column, SQL.EQ, new Variable(value)));
		return this;
	}

	public String from(String table)
	{
		String sql = this.operator + SQL.SPACE;
		String column = SQL.STAR;
		if (!this.columns.isEmpty())
		{
			column = String.join(", ", this.columns);
		}
		sql += column + " FROM " + table;
		if (!this.conditions.isEmpty())
		{
			sql += " WHERE ";
			sql += this.conditions
				.stream()
				.map(Condition::statement)
				.collect(Collectors.joining(SQL.SPACE + SQL.AND + SQL.SPACE));
		}
		sql += SQL.SEMICOLON;
		return sql;
	}

	public void apply(PreparedStatement statement)
	{
		VariableID idx = new VariableID();
		this.conditions.forEach(condition -> condition.apply(statement, idx));
	}
}
