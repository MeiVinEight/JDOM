package org.mve.query;

import java.sql.PreparedStatement;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Condition
{
	private final Object[] statement;

	public Condition(Object... statement)
	{
		this.statement = statement;
	}

	public String statement()
	{
		return "(" + Stream.of(this.statement).map(Object::toString).collect(Collectors.joining(SQL.SPACE)) + ")";
	}

	public void apply(PreparedStatement statement, VariableID idx)
	{
		Stream.of(this.statement)
			.filter(Variable.class::isInstance)
			.forEach(variable -> ((Variable) variable).apply(statement, idx));
	}

	@Override
	public String toString()
	{
		return this.statement();
	}
}
