package org.mve.dom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

@SpringBootApplication
public class JDOMApplication
{
	public static void main(String[] args)
	{
		System.setProperty("java.io.tmpdir", "temporary");
		ConfigurableApplicationContext run = SpringApplication.run(JDOMApplication.class, args);
	}
}
