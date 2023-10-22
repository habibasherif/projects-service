package com.sap.cap.productsservice.controllers;

import java.util.Map;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

public class WebSocketHandshakeInterceptor implements HandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
        // This method is called before the WebSocket handshake is performed
        // You can perform any necessary actions here
        System.out.println("New client connected: " + request.getRemoteAddress());
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Exception exception) {
        // This method is called after the WebSocket handshake is performed
        // You can perform any necessary actions here
        System.out.println("CLIENT CONNECTED SUCCESSFULLY");
    }

   
}
