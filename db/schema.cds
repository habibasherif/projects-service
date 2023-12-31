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
    Status : String (111) default 'available';
    Phase    : Association to Phases;
    Dimensions : Double;
    Block : String (111);
    Number : String (111);
    Content: LargeBinary @Core.MediaType:'image/svg+xml' ;
    Name : String (111);
    NameArabic : String (111);
    PathArabic :String(111);
   
}
entity PhaseGallery :cuid{
    image:LargeBinary @Core.MediaType:imageType @Core.ContentDisposition.Type: 'inline';
    imageType: String(111) @Core.IsMediaType;
    phase: Association to Phases;
    
}

entity ProjectGallery:cuid{
    image: LargeBinary @Core.MediaType:imageType @Core.ContentDisposition.Type:'inline';
    imageType: String(111) @Core.IsMediaType;
    project: Association to Projects;
   
}


@Capabilities.Updatable :true
@Capabilities.Deletable :true
entity Phases {
    key ID   : Integer ;
    project   : Association to Projects not null;
    gallery : Association to  many PhaseGallery on gallery.phase=$self;
    name : String (111);
    nameArabic :String (111);
    properties: Composition of many Properties on properties.Phase=$self;
    content: LargeBinary @Core.MediaType:'image/svg+xml' @Core.ContentDisposition.Type: 'inline';  
}

@Capabilities.Deletable :true
entity Projects {
    Key ID : Integer;
    phases : Composition of many Phases on phases.project=$self;
    content : LargeBinary @Core.MediaType:'image/svg+xml';
    name : localized String (111);
    image: LargeBinary @Core.MediaType:imageType @Core.ContentDisposition.Type: 'inline';
    imageType : String(111) @Core.IsMediaType;
    nameArabic :String(111);
    description : String;
    descriptionArabic :String;
    gallery : Association to many ProjectGallery on gallery.project=$self;
    

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


