package com.sap.cap.productsservice.handlers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.Update;
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
import cds.gen.adminservice.Properties_;
import cds.gen.adminservice.MassUploadProjectsContext;
import cds.gen.adminservice.Projects;
import cds.gen.adminservice.MassUploadMappingContext;
import cds.gen.adminservice.MappingTable;
import cds.gen.adminservice.MappingTable_;


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
        String result ="";
        boolean flag=false;

        for(MappingTable property : context.getProperties()){
            CqnSelect sel = Select.from(MappingTable_.class).where(p -> p.MapID().eq(property.getMapID()));
            if(db.run(sel).rowCount()>0){
                
                //MappingTable temp = (MappingTable)db.run(sel).first().get().as(MappingTable_.class);
                CqnSelect sel2 = Select.from(MappingTable_.class).where(p -> p.REFX().eq(property.getRefx().toString()));
                if(db.run(sel2).rowCount()>0){
                    if(!db.run(sel2).first().get().get("MapID").equals(property.getMapID().toString()) ){
                        flag = true;
                        result += "MapID: " + db.run(sel).first().get().get("MapID").toString() + " already exists with REFX: " + db.run(sel2).first().get().get("REFX").toString() +" /n";
                    }
                }
                else{
                    
                    //temp.setRefx(property.getRefx());
                    CqnUpdate update = Update.entity("AdminService.MappingTable").data("REFX",property.getRefx()).byId(property.getMapID());
                    db.run(update); 
                }


            }
            else{
                CqnSelect sel3 = Select.from(MappingTable_.class).where(p -> p.REFX().eq(property.getRefx()));
                if(db.run(sel3).rowCount()>0){
                    if(!db.run(sel3).first().get().get("MapID").equals( property.getMapID())){
                        flag = true;
                        result += "REFX: "+ property.getRefx().toString()+ " already exists with MapID: " +db.run(sel3).first().get().get("MapID")+" /n";
                    }   
                }
                else{

                    CqnInsert insert = Insert.into("AdminService.MappingTable").entry(property);
                    db.run(insert);
                }

            }
        }

        if(!flag){
            result = "Success";
        }
        
        context.setResult(result);
        

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
