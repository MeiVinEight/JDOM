package org.mve.query;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.MessageFormat;

public class Variable
{
	private static final Log logger = LogFactory.getLog(Variable.class);
	public final Object value;

	public Variable(Object value)
	{
		this.value = value;
	}

	public void apply(PreparedStatement statement, VariableID idx)
	{
		try
		{
			statement.setObject(idx.ID(), this.value);
		}
		catch (SQLException e)
		{
			logger.error(MessageFormat.format("Set value {0}", this.value), e);
		}
	}

	@Override
	public String toString()
	{
		return SQL.QUESTION;
	}
}
