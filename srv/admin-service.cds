using { sap.capire.properties as db } from '../db/schema';

 type MassUploadRet {
    MapID: String; 
    REFX:String; 
    Status:Integer;
    ErrorCode:Integer;
    ErrorMessage: String;
}


service AdminService {
    entity Properties   as projection on db.Properties;
    entity Phases as projection on db.Phases;
    entity Projects as projection on db.Projects;
    entity MappingTable as projection on db.ERPTable;
    action MassUploadProjects (Projects : array of Projects) returns array of Projects;
    action MassUploadMapping (Properties :array of MappingTable) returns array of MassUploadRet;
    action ExportToTable (Phase_ID: Integer , Project_ID: Integer) returns array of Properties;
    action TestConnection (phase : Phases) returns String;
    action Populate();
    
    
}


service PropertyService {
   @readonly entity Property as projection on db.Properties excluding {createdAt,createdBy,modifiedAt,modifiedBy,Path,Phase,Status};
    function getPropertyByMapID(MapID:String) returns String;
}



service UserService{
    @readonly entity Properties as projection on db.Properties;
    @readonly entity Projects as projection on db.Projects;
    @readonly entity Phases as projection on db.Phases;
    action SellProperty(Property : Properties , User : String) returns MassUploadRet;

    
}

annotate UserService with @(requires: 'any');
