package com.sap.cap.productsservice.handlers;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sap.cds.ql.Insert;
import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnInsert;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;
import cds.gen.exporttotable.MultipleEntriesContext;


import cds.gen.exporttotable.ExportToTable_;
import cds.gen.exporttotable.ERPTable_;
import cds.gen.exporttotable.ExportToTableContext;
import cds.gen.exporttotable.Property_;
import cds.gen.exporttotable.ERPTable;

@Component
@ServiceName(ExportToTable_.CDS_NAME)
public class ExportToTable implements EventHandler{

    @Autowired
    PersistenceService db;

    @On(event = ExportToTableContext.CDS_NAME)
    public void totest (ExportToTableContext context){
        CqnSelect sel = Select.from(ERPTable_.class);
      
        db.run(sel).forEach(p -> {
            Map <String , String> erp = new HashMap<>();
            erp.put("REFX", p.get("REFX").toString());
            erp.put("MapID", p.get("MapID").toString());
            CqnInsert insert = Insert.into("ExportTable.Property").entry(erp);

        });

        

       context.setResult("Success");
   
    }

    @On(event = MultipleEntriesContext.CDS_NAME)
    public void multipleEntries (MultipleEntriesContext context){
        System.out.println("Action Triggered");
        
        for(ERPTable entry : context.getProperties()){
            
            Map <String , String> erp = new HashMap<>();
            erp.put("REFX", entry.get("REFX").toString());
            
            erp.put("MapID", entry.get("MapID").toString());
            CqnInsert insert = Insert.into("ExportToTable.ERPTable").entry(erp);
            
            db.run(insert);

        }
        
        context.setResult(context.getProperties());

    }
    
}
