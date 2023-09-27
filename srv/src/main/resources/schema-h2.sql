
DROP VIEW IF EXISTS localized_fr_ExportToTable_Property;
DROP VIEW IF EXISTS localized_de_ExportToTable_Property;
DROP VIEW IF EXISTS localized_fr_AdminService_Properties;
DROP VIEW IF EXISTS localized_de_AdminService_Properties;
DROP VIEW IF EXISTS localized_fr_sap_capire_properties_Properties;
DROP VIEW IF EXISTS localized_de_sap_capire_properties_Properties;
DROP VIEW IF EXISTS localized_ExportToTable_Property;
DROP VIEW IF EXISTS localized_AdminService_Properties;
DROP VIEW IF EXISTS localized_sap_capire_properties_Properties;
DROP VIEW IF EXISTS ExportToTable_ERPTable_texts;
DROP VIEW IF EXISTS ExportToTable_Property_texts;
DROP VIEW IF EXISTS ExportToTable_Phases;
DROP VIEW IF EXISTS PropertyService_Property_texts;
DROP VIEW IF EXISTS AdminService_Properties_texts;
DROP VIEW IF EXISTS ExportToTable_ERPTable;
DROP VIEW IF EXISTS ExportToTable_Property;
DROP VIEW IF EXISTS PropertyService_Property;
DROP VIEW IF EXISTS AdminService_Projects;
DROP VIEW IF EXISTS AdminService_Phases;
DROP VIEW IF EXISTS AdminService_Properties;
DROP TABLE IF EXISTS sap_capire_properties_Properties_texts;
DROP TABLE IF EXISTS sap_capire_properties_Projects;
DROP TABLE IF EXISTS sap_capire_properties_Phases;
DROP TABLE IF EXISTS sap_capire_properties_Properties;

CREATE TABLE sap_capire_properties_Properties (
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  REFX NVARCHAR(111),
  MapID NVARCHAR(111) NOT NULL,
  Path NVARCHAR(1111),
  Status NVARCHAR(111),
  Phase_ID INTEGER,
  PRIMARY KEY(MapID),
  CONSTRAINT sap_capire_properties_Properties_REFX UNIQUE (REFX)
); 

CREATE TABLE sap_capire_properties_Phases (
  ID INTEGER NOT NULL,
  project_ID INTEGER NOT NULL,
  content NVARCHAR(111),
  PRIMARY KEY(ID)
); 

CREATE TABLE sap_capire_properties_Projects (
  ID INTEGER NOT NULL,
  content NVARCHAR(111),
  PRIMARY KEY(ID)
); 

CREATE TABLE sap_capire_properties_Properties_texts (
  locale NVARCHAR(14) NOT NULL,
  MapID NVARCHAR(111) NOT NULL,
  Path NVARCHAR(1111),
  PRIMARY KEY(locale, MapID)
); 

CREATE VIEW AdminService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID
FROM sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW AdminService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.content
FROM sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW AdminService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content
FROM sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW PropertyService_Property AS SELECT
  Properties_0.REFX,
  Properties_0.MapID
FROM sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW ExportToTable_Property AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID
FROM sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW ExportToTable_ERPTable AS SELECT
  Properties_0.REFX,
  Properties_0.MapID
FROM sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW AdminService_Properties_texts AS SELECT
  texts_0.locale,
  texts_0.MapID,
  texts_0.Path
FROM sap_capire_properties_Properties_texts AS texts_0; 

CREATE VIEW PropertyService_Property_texts AS SELECT
  texts_0.locale,
  texts_0.MapID,
  texts_0.Path
FROM sap_capire_properties_Properties_texts AS texts_0; 

CREATE VIEW ExportToTable_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.content
FROM sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW ExportToTable_Property_texts AS SELECT
  texts_0.locale,
  texts_0.MapID,
  texts_0.Path
FROM sap_capire_properties_Properties_texts AS texts_0; 

CREATE VIEW ExportToTable_ERPTable_texts AS SELECT
  texts_0.locale,
  texts_0.MapID,
  texts_0.Path
FROM sap_capire_properties_Properties_texts AS texts_0; 

CREATE VIEW localized_sap_capire_properties_Properties AS SELECT
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  L_0.REFX,
  L_0.MapID,
  coalesce(localized_1.Path, L_0.Path) AS Path,
  L_0.Status,
  L_0.Phase_ID
FROM (sap_capire_properties_Properties AS L_0 LEFT JOIN sap_capire_properties_Properties_texts AS localized_1 ON localized_1.MapID = L_0.MapID AND localized_1.locale = @locale); 

CREATE VIEW localized_AdminService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID
FROM localized_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_ExportToTable_Property AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID
FROM localized_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_de_sap_capire_properties_Properties AS SELECT
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  L_0.REFX,
  L_0.MapID,
  coalesce(localized_de_1.Path, L_0.Path) AS Path,
  L_0.Status,
  L_0.Phase_ID
FROM (sap_capire_properties_Properties AS L_0 LEFT JOIN sap_capire_properties_Properties_texts AS localized_de_1 ON localized_de_1.MapID = L_0.MapID AND localized_de_1.locale = @locale); 

CREATE VIEW localized_fr_sap_capire_properties_Properties AS SELECT
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  L_0.REFX,
  L_0.MapID,
  coalesce(localized_fr_1.Path, L_0.Path) AS Path,
  L_0.Status,
  L_0.Phase_ID
FROM (sap_capire_properties_Properties AS L_0 LEFT JOIN sap_capire_properties_Properties_texts AS localized_fr_1 ON localized_fr_1.MapID = L_0.MapID AND localized_fr_1.locale = @locale); 

CREATE VIEW localized_de_AdminService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID
FROM localized_de_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_fr_AdminService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID
FROM localized_fr_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_de_ExportToTable_Property AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID
FROM localized_de_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_fr_ExportToTable_Property AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID
FROM localized_fr_sap_capire_properties_Properties AS Properties_0; 

