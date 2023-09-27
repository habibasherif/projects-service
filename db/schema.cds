namespace sap.capire.properties;

using { Currency, cuid, managed, sap.common.CodeList } from '@sap/cds/common';

@assert.unique : {
   REFX: [ REFX ]
}
@Cross
@Capabilities.Deletable :true
entity Properties : managed {
    REFX   :  String (111);
    Key MapID: String (111);
    Path    : localized String(1111);
    Status : String (111);
    Phase    : Association to Phases;
   
}


@Capabilities.Deletable :true
entity Phases {
    key ID   : Integer;
    project   : Association to Projects not null;
    content : String (111);
}

@Capabilities.Deletable :true
entity Projects {
    Key ID : Integer;
    phases : Composition of many Phases on phases.project=$self;
    content : String(111);

}
