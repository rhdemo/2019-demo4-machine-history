package com.redhat.demo.util;

import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.ws.rs.core.MediaType;

import io.undertow.server.HttpServerExchange;
import io.undertow.servlet.ServletExtension;
import io.undertow.servlet.api.DeploymentInfo;
import io.undertow.servlet.api.ExceptionHandler;
import io.undertow.servlet.api.ServletStackTraces;
import io.undertow.util.Headers;

/**
 * TempServletExtension
 */
public class TempServletExtension implements ServletExtension {

    @Override
    public void handleDeployment(DeploymentInfo deploymentInfo, ServletContext servletContext) {
        deploymentInfo.setServletStackTraces(ServletStackTraces.ALL);
        deploymentInfo.setExceptionHandler(new ExceptionHandler() {
            @Override
            public boolean handleThrowable(HttpServerExchange exchange, ServletRequest request, ServletResponse response, Throwable throwable) {
                exchange.getResponseHeaders().add(Headers.CONTENT_TYPE, MediaType.TEXT_HTML);
                exchange.getResponseSender().send(ReplacementDebugPage.generateHtml(throwable));
                return true;
            }
        });
    }


}