package com.sap.cap.productsservice.controllers;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sap.cap.productsservice.TestingStomp.ReturnedGreeting;
import com.sap.cap.productsservice.handlers.AdminService;

import cds.gen.adminservice.Phases;



@Controller
public class GreetingController {


  @Autowired
  private AdminService adminService;


   @MessageMapping("/hello")
   @SendTo("/topic/greetings")
   public ReturnedGreeting greeting(String context) throws Exception {
    System.out.println("INSIDE GREETINGGGGG!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    
    ObjectMapper objectMapper = new ObjectMapper();
    try {
      JsonNode jsonNode = objectMapper.readTree(context);
      // Access the values of the JSON object
      String name = jsonNode.get("Name").asText();
      int id = jsonNode.get("Id").asInt();
      int project = jsonNode.get("Project").asInt();


      System.out.println("Name: " + name);
      System.out.println("Id: " + id);
      System.out.println("Project: " + project);

      
      Phases phase  = Phases.create();
      phase.setId(id);
      phase.setName(name);
      phase.setProjectId(project);
      adminService.testStomp(phase);

    } catch (IOException e) {
      e.printStackTrace();
    }

    
    
    return new ReturnedGreeting(HtmlUtils.htmlEscape("Change in Phase"));
   }

}