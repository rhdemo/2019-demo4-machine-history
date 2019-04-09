package com.redhat.demo.util;

import javax.servlet.ServletContext;

import io.undertow.servlet.ServletExtension;
import io.undertow.servlet.api.DeploymentInfo;
import io.undertow.servlet.api.ServletStackTraces;

/**
 * TempServletExtension
 */
public class TempServletExtension implements ServletExtension {

	@Override
	public void handleDeployment(DeploymentInfo deploymentInfo, ServletContext servletContext) {
		deploymentInfo.setServletStackTraces(ServletStackTraces.ALL);
	}

    
}