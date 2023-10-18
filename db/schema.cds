namespace sap.capire.properties;

using { Currency, cuid, managed, sap.common.CodeList } from '@sap/cds/common';

@assert.unique : {
   REFX: [ REFX ]
}
@Capabilities.Updatable :true
@Capabilities.Deletable :true
entity Properties : managed {
    REFX   :  String (111);
    Key MapID: String (111);
    Path    : localized String(1111);
    Status : String (111) default 'availale';
    Phase    : Association to Phases;
    Dimensions : Double;
    Block : String (111);
    Number : String (111);
   
}


@Capabilities.Updatable :true
@Capabilities.Deletable :true
entity Phases {
    key ID   : Integer;
    project   : Association to Projects not null;
    content : String (111);
    name : String (111);
    properties: Composition of many Properties on properties.Phase=$self;
}

@Capabilities.Deletable :true
entity Projects {
    Key ID : Integer;
    phases : Composition of many Phases on phases.project=$self;
    content : String(111);
    name : String (111);
    image: String (111);

}

@assert.unique : {
   REFX: [ REFX ]
}
@Capabilities.Updatable : true
entity ERPTable{
    REFX : String(111);
    key MapID : String(111);
    key Project : Association to Projects ;
    Phase : Association  to Phases;
    
}


