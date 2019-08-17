package com.songbowen.demo.consul.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HostnameController {

	@GetMapping(value = "/hostname", produces = "text/html")
	public String checkHealthy() throws UnknownHostException {
		InetAddress addr = InetAddress.getLocalHost();
		String hostName = addr.getHostName();
		return hostName;
	}
}
