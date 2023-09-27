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
    
}
