package com.sap.cap.productsservice.handlers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Delete;
import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.Update;
import com.sap.cds.ql.cqn.CqnDelete;
import com.sap.cds.ql.cqn.CqnInsert;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.ql.cqn.CqnUpdate;
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
import cds.gen.adminservice.Properties;

import cds.gen.adminservice.Properties_;
import cds.gen.adminservice.MassUploadProjectsContext;
import cds.gen.adminservice.Projects;
import cds.gen.adminservice.MassUploadMappingContext;
import cds.gen.adminservice.MappingTable;
import cds.gen.adminservice.MappingTable_;
import cds.gen.MassUploadRet;
import cds.gen.adminservice.ExportToTableContext;


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
                        ret.setErrorMessage("Duplication in REFX"); 
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
                        ret.setErrorMessage("Duplication in REFX"); 
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
        CqnSelect sel = Select.from(MappingTable_.class);
        List<MappingTable> mappings=db.run(sel).listOf(MappingTable.class);
        for(MappingTable map : mappings){
            Properties property = Properties.create();
            property.setMapID(map.getMapID());
            property.setRefx(map.getRefx());
            property.setPhaseId(map.getPhaseId());
            CqnInsert insert = Insert.into("AdminService.Properties").entry(property);
            db.run(insert);
            CqnDelete delete = Delete.from(MappingTable_.class)
            .where(b -> b.MapID().eq(property.getMapID()));
            db.run(delete);
        }
        
        CqnSelect sel2 = Select.from(Properties_.class);
        context.setResult(db.run(sel2).listOf(Properties.class));


    }

   
    
}
