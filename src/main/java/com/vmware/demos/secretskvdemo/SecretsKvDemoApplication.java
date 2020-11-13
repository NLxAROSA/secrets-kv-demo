package com.vmware.demos.secretskvdemo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class SecretsKvDemoApplication {

	private static final Logger LOGGER = LoggerFactory.getLogger(SecretsKvDemoApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(SecretsKvDemoApplication.class, args);
	}

	@Bean
	CommandLineRunner getSecretBootstrap(@Value("${lroSecretName:nothing}") String secret)	{

		return args ->	{
			LOGGER.info("The secret is: " + secret);
		};

	}

}
