package com.songbowen.demo.consul.controller;

import java.net.UnknownHostException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthyCheckController {

	@GetMapping(value = "/healthy", produces = "text/html")
	public String checkHealthy() throws UnknownHostException {
		return "OK";
	}
}
