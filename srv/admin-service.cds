using { sap.capire.properties as db } from '../db/schema';

service AdminService {
    entity Properties   as projection on db.Properties;
    entity Phases as projection on db.Phases;
    entity Projects as projection on db.Projects;
    entity MappingTable as projection on db.ERPTable;
    action MassUploadProjects (Projects : array of Projects) returns array of Projects;
    action MassUploadMapping (Properties :array of MappingTable) returns String;
    action ExportToTable () returns array of Properties;
    
    
}


service PropertyService {
   @readonly entity Property as projection on db.Properties excluding {createdAt,createdBy,modifiedAt,modifiedBy,Path,Phase,Status};
    function getPropertyByMapID(MapID:String) returns String;
}

