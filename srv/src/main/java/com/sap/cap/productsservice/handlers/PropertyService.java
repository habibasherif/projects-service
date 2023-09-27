package com.sap.cap.productsservice.handlers;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.sap.cds.ql.Select;
import com.sap.cds.ql.cqn.CqnSelect;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;
import com.sap.cds.services.persistence.PersistenceService;
import cds.gen.propertyservice.PropertyService_;
import cds.gen.propertyservice.Property_;
import cds.gen.propertyservice.Property;
import cds.gen.propertyservice.GetPropertyByMapIDContext;


@Component
@ServiceName(PropertyService_.CDS_NAME)
public class PropertyService  implements EventHandler{

    @Autowired
    PersistenceService db;

    // public List<Property_> getPropertyByMapID (GetPropertyByMapIDContext context){
        
    //     //CqnSelect sel = Select.from(Property_.class).where(p -> p.MapID().eq(context.getMapID()));
    //     //return (db.run(sel).listOf(Property_.class));
        


    // }
    
    @On(event = GetPropertyByMapIDContext.CDS_NAME)
    public void totest (GetPropertyByMapIDContext context){
        CqnSelect sel = Select.from(Property_.class).where( p -> (p.MapID()).eq(context.getMapID()));
        context.setResult(db.run(sel).listOf(Property_.class).toString());

        //context.setResult("Hello");
   
    }
   

}