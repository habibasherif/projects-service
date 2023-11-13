package com.sap.cap.productsservice.handlers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Component;

import com.sap.cap.productsservice.TestingStomp.ReturnedGreeting;
import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.Update;
import com.sap.cds.ql.Upsert;
import com.sap.cds.ql.cqn.CqnInsert;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.ql.cqn.CqnUpdate;
import com.sap.cds.ql.cqn.CqnUpsert;
import com.sap.cds.services.cds.CdsCreateEventContext;
import com.sap.cds.services.cds.CdsUpdateEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.messages.Messages;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.MassUploadRet;
import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.ExportToTableContext;
import cds.gen.adminservice.MappingTable;
import cds.gen.adminservice.MappingTable_;
import cds.gen.adminservice.MassUploadMappingContext;
import cds.gen.adminservice.MassUploadProjectsContext;
import cds.gen.adminservice.Phases;
import cds.gen.adminservice.PopulateContext;
import cds.gen.adminservice.Properties;
import cds.gen.adminservice.Properties_;
import cds.gen.adminservice.TestConnectionContext;

@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminService implements EventHandler{
    @Autowired
    PersistenceService db;

    @Autowired
    Messages messages;

    private int ProjectcurrentID=100;
    private int PhasecurrentID=100;

    private final SimpMessagingTemplate messagingTemplate;

    @On(event= CqnService.EVENT_CREATE, entity = "AdminService.Properties")
    public void onCreate (CdsCreateEventContext context) {

        String REFX = context.getCqn().entries().get(0).get("REFX").toString();
    
        // Check if REFX already exists with another MapID
        CqnSelect sel = Select.from(Properties_.class).where( r -> r.REFX().eq(REFX));

        if(db.run(sel).rowCount()>0){
            messages.warn("Already Exists with MapID {}",db.run(sel).first().get().get("MapID"));
        }

        String tempMap = context.getCqn().entries().get(0).get("MapID").toString();
       // String MapID = tempMap.substring(7,tempMap.length()-1);
        sel = Select.from(Properties_.class).where(r -> r.MapID().eq(tempMap));
        if(db.run(sel).rowCount()>0){
            messages.warn("Already exists with REFX {}",db.run(sel).first().get().get("REFX_REFX"));
        }

        
    }

    @On(event = MassUploadProjectsContext.CDS_NAME)
    public void MassUploadProjects (MassUploadProjectsContext context){
       // for(Projects project : context.getProjects()){
        CqnInsert insert = Insert.into("AdminService.Projects").entries(context.getProjects());
        db.run(insert);
        context.setResult(context.getProjects());


        //}
    }

    @On(event = PopulateContext.CDS_NAME)
    public void Populate (PopulateContext context){
      
        CqnSelect sel = Select.from(Properties_.class);
        List<Properties> properties= db.run(sel).listOf(Properties.class);
        for(Properties property : properties){
            
            property.setStatus("available");
            //property.setDimensions(304.5);
            
        }
        CqnUpsert upsert = Upsert.into("AdminService.Properties").entries(properties);
        db.run(upsert);
        context.setCompleted();


        //}
    }

    @On(event = MassUploadMappingContext.CDS_NAME)
    public void multipleEntries (MassUploadMappingContext context){
        List<MassUploadRet> toReturn = new ArrayList<>(); 

        for(MappingTable property : context.getProperties()){
            CqnSelect sel = Select.from(MappingTable_.class).where(p -> p.MapID().eq(property.getMapID()));
            if(db.run(sel).rowCount()>0){
                
                //MappingTable temp = (MappingTable)db.run(sel).first().get().as(MappingTable_.class);
                CqnSelect sel2 = Select.from(MappingTable_.class).where(p -> p.REFX().eq(property.getRefx().toString()));
                if(db.run(sel2).rowCount()>0){
                    if(!db.run(sel2).first().get().get("MapID").equals(property.getMapID().toString()) ){
                        MassUploadRet ret = MassUploadRet.create();
                        ret.setMapID(property.getMapID().toString());
                        ret.setRefx(db.run(sel).first().get().get("REFX").toString());
                        ret.setStatus(500);
                        ret.setErrorCode(600);
                        ret.setErrorMessage("Duplication in REFX ("+property.getRefx()+")"); 
                        toReturn.add(ret);
                    }
                    else{
                        CqnUpdate update = Update.entity("AdminService.MappingTable").data(property);
                        db.run(update);
                        MassUploadRet ret = MassUploadRet.create();
                        ret.setMapID(property.getMapID().toString());
                        ret.setRefx(property.getRefx().toString());
                        ret.setStatus(200);
                        toReturn.add(ret);
                        

                    }
                }
                else{
                    CqnUpdate update = Update.entity("AdminService.MappingTable").data(property);
                    db.run(update);
                    MassUploadRet ret = MassUploadRet.create();
                    ret.setMapID(property.getMapID().toString());
                    ret.setRefx(property.getRefx().toString());
                    ret.setStatus(200);
                    toReturn.add(ret);
                }


            }
            else{
                CqnSelect sel3 = Select.from(MappingTable_.class).where(p -> p.REFX().eq(property.getRefx()));
                if(db.run(sel3).rowCount()>0){
                    if(!db.run(sel3).first().get().get("MapID").equals( property.getMapID())){
                        MassUploadRet ret = MassUploadRet.create();
                        ret.setMapID(property.getMapID().toString());
                        ret.setRefx(db.run(sel3).first().get().get("REFX").toString());
                        ret.setStatus(500);
                        ret.setErrorCode(600);
                        ret.setErrorMessage("Duplication in REFX ("+property.getRefx()+")");
                        toReturn.add(ret);
                    }
                    else{
                        CqnUpdate update = Update.entity("AdminService.MappingTable").data(property);

                        db.run(update);
                        MassUploadRet ret = MassUploadRet.create();
                        ret.setMapID(property.getMapID().toString());
                        ret.setRefx(property.getRefx().toString());
                        ret.setStatus(200);
                        toReturn.add(ret);

                    }
                }
                else{

                    CqnInsert insert = Insert.into("AdminService.MappingTable").entry(property);
                    db.run(insert);
                    MassUploadRet ret = MassUploadRet.create();
                    ret.setMapID(property.getMapID().toString());
                    ret.setRefx(property.getRefx().toString());
                    ret.setStatus(200);
                    toReturn.add(ret);
                }

            }
        }

        
        
        context.setResult(toReturn);
        

    }


    @On (event = ExportToTableContext.CDS_NAME)
    public void ExportToTable(ExportToTableContext context){
        CqnSelect sel = Select.from(MappingTable_.class).where(p -> p.Project_ID().eq((context.getProjectId())) .and( p.Phase_ID().eq((context.getPhaseId())))); 
        List<MappingTable> mappings=db.run(sel).listOf(MappingTable.class);
        for(MappingTable map : mappings){
            Properties property = Properties.create();
            property.setMapID(map.getMapID());
            property.setRefx(map.getRefx());
            property.setPhaseId(map.getPhaseId());
            property.setStatus("available");
            CqnInsert insert = Insert.into("AdminService.Properties").entry(property);
            db.run(insert);
            //CqnDelete delete = Delete.from(MappingTable_.class)
           // .where(b -> b.MapID().eq(property.getMapID()));
            //db.run(delete);
        }
        
        CqnSelect sel2 = Select.from(Properties_.class);
        context.setResult(db.run(sel2).listOf(Properties.class));


    }


    
    
    public void testStomp (Phases phase){

       // HelloMessage m = new HelloMessage(context.toString());

       // return new ReturnedGreeting(HtmlUtils.htmlEscape(m.getMessage()));
       
       CqnInsert insert = Insert.into("AdminService.Phases").entry(phase);
       db.run(insert);
        
        
    }

    @SendTo("/topic/greetings")
    @On(event = TestConnectionContext.CDS_NAME)
    public void TestConnection (TestConnectionContext context){
       // for(Projects project : context.getProjects()){
        CqnInsert insert = Insert.into("AdminService.Phases").entry(context.getPhase());
        db.run(insert);
        context.setResult("{Project ID: " +context.getPhase().getProjectId() + ", \"PhaseID\": " + context.getPhase().getId() +"}" );
        System.out.println("Should post1");

       // publishToWebSocket("{\"ProjectID\": " +context.getPhase().getProjectId() + ", \"PhaseID\": " + context.getPhase().getId() +"}" );
        System.out.println("Should post");
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

    

    @Autowired
    public AdminService(SimpMessagingTemplate messagingTemplate) {
        this.messagingTemplate = messagingTemplate;
    }

    @On(event= CqnService.EVENT_UPDATE, entity = "AdminService.Properties")
    public void onUpdate (CdsUpdateEventContext context) {
        System.out.println(context.getCqn().entries().get(0).toString());
        //System.out.println("Project: "+context.getCqn().entries().get(0).get("Project_ID").toString() +", Phase: "+context.getCqn().entries().get(0).get("Phase_ID").toString());

        CqnSelect select = Select.from("AdminService.Phases").byId(Integer.parseInt(context.getCqn().entries().get(0).get("Phase_ID").toString()));

        //Phase phase = db.run(select).

        Phases phase = db.run(select).listOf(Phases.class).get(0);
        publishToWebSocket((context.getCqn().entries().get(0).toString()),phase.getProjectId().toString(),context.getCqn().entries().get(0).get("Phase_ID").toString());


    }

    
    @On(event= CqnService.EVENT_CREATE, entity = "AdminService.Projects")
    public void onCreateProject (CdsCreateEventContext context) {
        
        context.getCqn().entries().forEach(p -> p.put("ID",ProjectcurrentID++));
        
        context.setResult(context.getCqn().entries());

    }
    @On(event= CqnService.EVENT_CREATE, entity = "AdminService.Phases")
    public void onCreatePhases (CdsCreateEventContext context) {
        
        context.getCqn().entries().forEach(p -> p.put("ID",PhasecurrentID++));
        context.setResult(context.getCqn().entries());

    }

   
    
}
