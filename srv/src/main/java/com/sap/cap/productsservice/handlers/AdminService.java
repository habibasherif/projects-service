package com.sap.cap.productsservice.handlers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnInsert;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.ServiceException;
import com.sap.cds.services.cds.CdsCreateEventContext;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.messages.Messages;
import com.sap.cds.services.persistence.PersistenceService;

import cds.gen.adminservice.AdminService_;
import cds.gen.adminservice.Properties_;
import cds.gen.adminservice.Properties_;
import cds.gen.adminservice.MassUploadProjectsContext;
import cds.gen.adminservice.Projects;
import cds.gen.adminservice.MassUploadMappingContext;
import cds.gen.adminservice.MappingTable;


@Component
@ServiceName(AdminService_.CDS_NAME)
public class AdminService implements EventHandler{
    @Autowired
    PersistenceService db;

    @Autowired
    Messages messages;


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
    @On(event = MassUploadMappingContext.CDS_NAME)
    public void multipleEntries (MassUploadMappingContext context){
        CqnInsert insert = Insert.into("AdminService.MappingTable").entries(context.getProperties());
        db.run(insert);
        context.setResult(context.getProperties());
        

    }

    // @On(event = ExportToTableContext.CDS_NAME)
    // public void totest (ExportToTableContext context){
    //     CqnSelect sel = Select.from(ERPTable_.class);
      
    //     db.run(sel).forEach(p -> {
    //         Map <String , String> erp = new HashMap<>();
    //         erp.put("REFX", p.get("REFX").toString());
    //         erp.put("MapID", p.get("MapID").toString());
    //         CqnInsert insert = Insert.into("ExportTable.Property").entry(erp);

    //     });

        

    //    context.setResult("Success");
   
    // }
    
}
