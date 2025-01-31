package org.mve.dom.logging.converter;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.spi.ILoggingEvent;
import org.springframework.boot.logging.logback.ColorConverter;

public class LoggingLevel extends ColorConverter
{
	@Override
	public String transform(ILoggingEvent event, String in)
	{
		return switch (event.getLevel().toInt())
		{
			case Level.DEBUG_INT -> "\033[1m\033[36m" + in + "\033[0m";
			case Level.TRACE_INT -> "\033[1m\033[34m" + in + "\033[0m";
			case Level.INFO_INT  -> "\033[1m\033[32m" + in + "\033[0m";
			case Level.WARN_INT  -> "\033[1m\033[33m" + in + "\033[0m";
			case Level.ERROR_INT -> "\033[1m\033[31m" + in + "\033[0m";
			default -> in;
		};
	}
}
