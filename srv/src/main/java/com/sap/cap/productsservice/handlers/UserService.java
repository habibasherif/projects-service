package com.sap.cap.productsservice.handlers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.sap.cap.productsservice.TestingStomp.ReturnedGreeting;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.Upsert;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.ql.cqn.CqnUpsert;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.MassUploadRet;
import cds.gen.WebSocketUpdateRet;
import cds.gen.WebSocketUpdateRet.Data;
import cds.gen.userservice.Properties;
import cds.gen.userservice.Properties_;
import cds.gen.userservice.SellPropertyContext;
import cds.gen.userservice.UserService_;


@ServiceName(UserService_.CDS_NAME)
@Component
public class UserService implements EventHandler{

    @Autowired
    PersistenceService db;

    @Autowired
    private RestTemplate restTemplate;
    private final SimpMessagingTemplate messagingTemplate;

    @On(event = SellPropertyContext.CDS_NAME)
    public void SellProperty (SellPropertyContext context){
        System.out.println("HEREEEEEEEEEEEE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
       // for(Projects project : context.getProjects()){

        Properties prop = context.getProperty();

        if(prop.getStatus().equalsIgnoreCase("Sold")){

            CqnSelect sel = Select.from(Properties_.class).where(p -> p.REFX().eq(prop.getRefx().toString()));

            if(db.run(sel).rowCount()<1){
                MassUploadRet ret = MassUploadRet.create();
                ret.setMapID(prop.getMapID());
                ret.setRefx(prop.getRefx());
                ret.setStatus(500);
                ret.setErrorCode(502);
                ret.setErrorMessage("Property not Found");
                context.setResult(ret);
                context.setCompleted();
                return;
            }
            String status = db.run(sel).first().get().get("Status").toString();
            if(status.equalsIgnoreCase("Available")){
                prop.setStatus("sold");
                CqnUpsert upsert = Upsert.into(Properties_.class).entry(prop);
                db.run(upsert);

                if(context.getUser()==null){
                    MassUploadRet ret = MassUploadRet.create();
                    ret.setMapID(prop.getMapID());
                    ret.setRefx(prop.getRefx());
                    ret.setStatus(500);
                    ret.setErrorCode(503);
                    ret.setErrorMessage("Error in Lead Creation");
                    context.setResult(ret);
                    CqnSelect select = Select.from("AdminService.Phases").byId(prop.getPhaseId());
                publishToWebSocket(ret.toString(), db.run(select).first().get().get("project_ID").toString(), prop.getPhaseId().toString());
        

                }
                else{
                if(sendCall(context.getUser()).equals("OK")){
                    MassUploadRet ret = MassUploadRet.create();
                    ret.setMapID(prop.getMapID());
                    ret.setRefx(prop.getRefx());
                    ret.setStatus(200);
                    context.setResult(ret);
                    CqnSelect select = Select.from("AdminService.Phases").byId(prop.getPhaseId());
                    WebSocketUpdateRet websocketret = WebSocketUpdateRet.create();
                    Data data = Data.create();
                    
                    data.setMapID(prop.getMapID());
                    data.setRefx(prop.getRefx());
                    data.setStatus("Sold");
                    websocketret.setData(data);
                    
                    publishToWebSocket(websocketret.toString(), db.run(select).first().get().get("project_ID").toString(), prop.getPhaseId().toString());
                    
                }
                else{

                    MassUploadRet ret = MassUploadRet.create();
                    ret.setMapID(prop.getMapID());
                    ret.setRefx(prop.getRefx());
                    ret.setStatus(500);
                    ret.setErrorCode(503);
                    ret.setErrorMessage("Error in Lead Creation");
                    context.setResult(ret);
                    
                }
            }

            }
            else{
                MassUploadRet ret = MassUploadRet.create();
                ret.setMapID(prop.getMapID());
                ret.setRefx(prop.getRefx());
                ret.setStatus(500);
                ret.setErrorCode(501);
                ret.setErrorMessage("Property not Available");
                context.setResult(ret);
                
            }
            
        }
        
        context.setCompleted();



        //}
    }
     @Autowired
    public UserService(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }
    public void publishToWebSocket(String message ,String project , String phase) {
        System.out.println("Here");
        messagingTemplate.convertAndSend("/topic/App",  new ReturnedGreeting(message));
        messagingTemplate.convertAndSend("/topic/Project/"+project,  new ReturnedGreeting(message));
        messagingTemplate.convertAndSend("/topic/Phase/"+phase,  new ReturnedGreeting(message));
        String greeting = "greetings";
        messagingTemplate.convertAndSend("/topic/"+greeting,  new ReturnedGreeting(message));




        System.out.println("DONEE");

    }


    public String sendCall(String user){
         String url = "https://edraky-development-environment-m6cksw9c.it-cpi024-rt.cfapps.eu10-002.hana.ondemand.com/http/MasterApp/C4C/Lead";
    HttpMethod method = HttpMethod.POST;

    // Define the request body
    String requestBody = "{\n" +
    "    \"Name\": \"" + user + "\",\n" +
    "    \"Company\": \"Master App\"\n" +
    "}";

    // Define the headers
    HttpHeaders headers = new HttpHeaders();
    headers.setContentType(MediaType.APPLICATION_JSON);
    headers.setBasicAuth("habiba.sherif@edraky.com", "happyBee123");

    // Create the HttpEntity with the request body and headers
    HttpEntity<String> requestEntity = new HttpEntity<>(requestBody, headers);

    // Make the REST call
    ResponseEntity<String> response = restTemplate.exchange(url, method, requestEntity, String.class);

    // Process the response
    if (response.getStatusCode().is2xxSuccessful()) {
        String responseBody = response.getBody();
        // Process the response body
        return "OK";
    } else {
        // Handle the error case
        return "NO";
    }
    


    }


    
}
