using { sap.capire.properties as db } from '../db/schema';

service AdminService {
    entity Properties   as projection on db.Properties;
    entity Phases as projection on db.Phases;
    entity Projects as projection on db.Projects;
}


service PropertyService {
   @readonly entity Property as projection on db.Properties excluding {createdAt,createdBy,modifiedAt,modifiedBy,Path,Phase,Status};
    function getPropertyByMapID(MapID:String) returns String;
}

service ExportToTable{
    entity Property as projection on db.Properties;
    entity ERPTable as projection on db.Properties excluding {createdAt,createdBy,Status,Phase,modifiedAt,modifiedBy,Path};

    function ExportToTable() returns String;
    action multipleEntries (Properties: array of ERPTable) returns array of ERPTable;
}