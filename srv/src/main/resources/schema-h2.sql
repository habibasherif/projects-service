
DROP VIEW IF EXISTS localized_fr_UserService_PhaseGallery;
DROP VIEW IF EXISTS localized_de_UserService_PhaseGallery;
DROP VIEW IF EXISTS localized_fr_AdminService_PhaseGallery;
DROP VIEW IF EXISTS localized_de_AdminService_PhaseGallery;
DROP VIEW IF EXISTS localized_fr_UserService_ProjectGallery;
DROP VIEW IF EXISTS localized_de_UserService_ProjectGallery;
DROP VIEW IF EXISTS localized_fr_UserService_Phases;
DROP VIEW IF EXISTS localized_de_UserService_Phases;
DROP VIEW IF EXISTS localized_fr_AdminService_ProjectGallery;
DROP VIEW IF EXISTS localized_de_AdminService_ProjectGallery;
DROP VIEW IF EXISTS localized_fr_AdminService_MappingTable;
DROP VIEW IF EXISTS localized_de_AdminService_MappingTable;
DROP VIEW IF EXISTS localized_fr_AdminService_Phases;
DROP VIEW IF EXISTS localized_de_AdminService_Phases;
DROP VIEW IF EXISTS localized_fr_UserService_Projects;
DROP VIEW IF EXISTS localized_de_UserService_Projects;
DROP VIEW IF EXISTS localized_fr_UserService_Properties;
DROP VIEW IF EXISTS localized_de_UserService_Properties;
DROP VIEW IF EXISTS localized_fr_AdminService_Projects;
DROP VIEW IF EXISTS localized_de_AdminService_Projects;
DROP VIEW IF EXISTS localized_fr_AdminService_Properties;
DROP VIEW IF EXISTS localized_de_AdminService_Properties;
DROP VIEW IF EXISTS localized_fr_sap_capire_properties_PhaseGallery;
DROP VIEW IF EXISTS localized_de_sap_capire_properties_PhaseGallery;
DROP VIEW IF EXISTS localized_fr_sap_capire_properties_ERPTable;
DROP VIEW IF EXISTS localized_de_sap_capire_properties_ERPTable;
DROP VIEW IF EXISTS localized_fr_sap_capire_properties_Phases;
DROP VIEW IF EXISTS localized_de_sap_capire_properties_Phases;
DROP VIEW IF EXISTS localized_fr_sap_capire_properties_ProjectGallery;
DROP VIEW IF EXISTS localized_de_sap_capire_properties_ProjectGallery;
DROP VIEW IF EXISTS localized_fr_sap_capire_properties_Projects;
DROP VIEW IF EXISTS localized_de_sap_capire_properties_Projects;
DROP VIEW IF EXISTS localized_fr_sap_capire_properties_Properties;
DROP VIEW IF EXISTS localized_de_sap_capire_properties_Properties;
DROP VIEW IF EXISTS localized_UserService_PhaseGallery;
DROP VIEW IF EXISTS localized_AdminService_PhaseGallery;
DROP VIEW IF EXISTS localized_UserService_ProjectGallery;
DROP VIEW IF EXISTS localized_UserService_Phases;
DROP VIEW IF EXISTS localized_AdminService_ProjectGallery;
DROP VIEW IF EXISTS localized_AdminService_MappingTable;
DROP VIEW IF EXISTS localized_AdminService_Phases;
DROP VIEW IF EXISTS localized_UserService_Projects;
DROP VIEW IF EXISTS localized_UserService_Properties;
DROP VIEW IF EXISTS localized_AdminService_Projects;
DROP VIEW IF EXISTS localized_AdminService_Properties;
DROP VIEW IF EXISTS localized_sap_capire_properties_PhaseGallery;
DROP VIEW IF EXISTS localized_sap_capire_properties_ERPTable;
DROP VIEW IF EXISTS localized_sap_capire_properties_Phases;
DROP VIEW IF EXISTS localized_sap_capire_properties_ProjectGallery;
DROP VIEW IF EXISTS localized_sap_capire_properties_Projects;
DROP VIEW IF EXISTS localized_sap_capire_properties_Properties;
DROP VIEW IF EXISTS UserService_Projects_texts;
DROP VIEW IF EXISTS UserService_Properties_texts;
DROP VIEW IF EXISTS PropertyService_Property_texts;
DROP VIEW IF EXISTS AdminService_Projects_texts;
DROP VIEW IF EXISTS AdminService_Properties_texts;
DROP VIEW IF EXISTS UserService_PhaseGallery;
DROP VIEW IF EXISTS UserService_ProjectGallery;
DROP VIEW IF EXISTS UserService_Phases;
DROP VIEW IF EXISTS UserService_Projects;
DROP VIEW IF EXISTS UserService_Properties;
DROP VIEW IF EXISTS PropertyService_Property;
DROP VIEW IF EXISTS AdminService_ProjectGallery;
DROP VIEW IF EXISTS AdminService_PhaseGallery;
DROP VIEW IF EXISTS AdminService_MappingTable;
DROP VIEW IF EXISTS AdminService_Projects;
DROP VIEW IF EXISTS AdminService_Phases;
DROP VIEW IF EXISTS AdminService_Properties;
DROP TABLE IF EXISTS sap_capire_properties_Projects_texts;
DROP TABLE IF EXISTS sap_capire_properties_Properties_texts;
DROP TABLE IF EXISTS sap_capire_properties_ERPTable;
DROP TABLE IF EXISTS sap_capire_properties_Projects;
DROP TABLE IF EXISTS sap_capire_properties_Phases;
DROP TABLE IF EXISTS sap_capire_properties_ProjectGallery;
DROP TABLE IF EXISTS sap_capire_properties_PhaseGallery;
DROP TABLE IF EXISTS sap_capire_properties_Properties;

CREATE TABLE sap_capire_properties_Properties (
  createdAt TIMESTAMP(7),
  createdBy NVARCHAR(255),
  modifiedAt TIMESTAMP(7),
  modifiedBy NVARCHAR(255),
  REFX NVARCHAR(111),
  MapID NVARCHAR(111) NOT NULL,
  Path NVARCHAR(1111),
  Status NVARCHAR(111) DEFAULT 'available',
  Phase_ID INTEGER,
  Dimensions DOUBLE,
  Block NVARCHAR(111),
  Number NVARCHAR(111),
  Content BINARY LARGE OBJECT,
  Name NVARCHAR(111),
  NameArabic NVARCHAR(111),
  PathArabic NVARCHAR(111),
  PRIMARY KEY(MapID),
  CONSTRAINT sap_capire_properties_Properties_REFX UNIQUE (REFX)
); 

CREATE TABLE sap_capire_properties_PhaseGallery (
  ID NVARCHAR(36) NOT NULL,
  image BINARY LARGE OBJECT,
  imageType NVARCHAR(111),
  phase_ID INTEGER,
  PRIMARY KEY(ID)
); 

CREATE TABLE sap_capire_properties_ProjectGallery (
  ID NVARCHAR(36) NOT NULL,
  image BINARY LARGE OBJECT,
  imageType NVARCHAR(111),
  project_ID INTEGER,
  PRIMARY KEY(ID)
); 

CREATE TABLE sap_capire_properties_Phases (
  ID INTEGER NOT NULL,
  project_ID INTEGER NOT NULL,
  name NVARCHAR(111),
  nameArabic NVARCHAR(111),
  content BINARY LARGE OBJECT,
  PRIMARY KEY(ID)
); 

CREATE TABLE sap_capire_properties_Projects (
  ID INTEGER NOT NULL,
  content BINARY LARGE OBJECT,
  name NVARCHAR(111),
  image BINARY LARGE OBJECT,
  imageType NVARCHAR(111),
  nameArabic NVARCHAR(111),
  description NVARCHAR(255),
  descriptionArabic NVARCHAR(255),
  PRIMARY KEY(ID)
); 

CREATE TABLE sap_capire_properties_ERPTable (
  REFX NVARCHAR(111),
  MapID NVARCHAR(111) NOT NULL,
  Project_ID INTEGER NOT NULL,
  Phase_ID INTEGER,
  PRIMARY KEY(MapID, Project_ID),
  CONSTRAINT sap_capire_properties_ERPTable_REFX UNIQUE (REFX)
); 

CREATE TABLE sap_capire_properties_Properties_texts (
  locale NVARCHAR(14) NOT NULL,
  MapID NVARCHAR(111) NOT NULL,
  Path NVARCHAR(1111),
  PRIMARY KEY(locale, MapID)
); 

CREATE TABLE sap_capire_properties_Projects_texts (
  locale NVARCHAR(14) NOT NULL,
  ID INTEGER NOT NULL,
  name NVARCHAR(111),
  PRIMARY KEY(locale, ID)
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
  Properties_0.Phase_ID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
FROM sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW AdminService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.name,
  Phases_0.nameArabic,
  Phases_0.content
FROM sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW AdminService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content,
  Projects_0.name,
  Projects_0.image,
  Projects_0.imageType,
  Projects_0.nameArabic,
  Projects_0.description,
  Projects_0.descriptionArabic
FROM sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW AdminService_MappingTable AS SELECT
  ERPTable_0.REFX,
  ERPTable_0.MapID,
  ERPTable_0.Project_ID,
  ERPTable_0.Phase_ID
FROM sap_capire_properties_ERPTable AS ERPTable_0; 

CREATE VIEW AdminService_PhaseGallery AS SELECT
  PhaseGallery_0.ID,
  PhaseGallery_0.image,
  PhaseGallery_0.imageType,
  PhaseGallery_0.phase_ID
FROM sap_capire_properties_PhaseGallery AS PhaseGallery_0; 

CREATE VIEW AdminService_ProjectGallery AS SELECT
  ProjectGallery_0.ID,
  ProjectGallery_0.image,
  ProjectGallery_0.imageType,
  ProjectGallery_0.project_ID
FROM sap_capire_properties_ProjectGallery AS ProjectGallery_0; 

CREATE VIEW PropertyService_Property AS SELECT
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
FROM sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW UserService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
FROM sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW UserService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content,
  Projects_0.name,
  Projects_0.image,
  Projects_0.imageType,
  Projects_0.nameArabic,
  Projects_0.description,
  Projects_0.descriptionArabic
FROM sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW UserService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.name,
  Phases_0.nameArabic,
  Phases_0.content
FROM sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW UserService_ProjectGallery AS SELECT
  ProjectGallery_0.ID,
  ProjectGallery_0.image,
  ProjectGallery_0.imageType,
  ProjectGallery_0.project_ID
FROM sap_capire_properties_ProjectGallery AS ProjectGallery_0; 

CREATE VIEW UserService_PhaseGallery AS SELECT
  PhaseGallery_0.ID,
  PhaseGallery_0.image,
  PhaseGallery_0.imageType,
  PhaseGallery_0.phase_ID
FROM sap_capire_properties_PhaseGallery AS PhaseGallery_0; 

CREATE VIEW AdminService_Properties_texts AS SELECT
  texts_0.locale,
  texts_0.MapID,
  texts_0.Path
FROM sap_capire_properties_Properties_texts AS texts_0; 

CREATE VIEW AdminService_Projects_texts AS SELECT
  texts_0.locale,
  texts_0.ID,
  texts_0.name
FROM sap_capire_properties_Projects_texts AS texts_0; 

CREATE VIEW PropertyService_Property_texts AS SELECT
  texts_0.locale,
  texts_0.MapID,
  texts_0.Path
FROM sap_capire_properties_Properties_texts AS texts_0; 

CREATE VIEW UserService_Properties_texts AS SELECT
  texts_0.locale,
  texts_0.MapID,
  texts_0.Path
FROM sap_capire_properties_Properties_texts AS texts_0; 

CREATE VIEW UserService_Projects_texts AS SELECT
  texts_0.locale,
  texts_0.ID,
  texts_0.name
FROM sap_capire_properties_Projects_texts AS texts_0; 

CREATE VIEW localized_sap_capire_properties_Properties AS SELECT
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  L_0.REFX,
  L_0.MapID,
  coalesce(localized_1.Path, L_0.Path) AS Path,
  L_0.Status,
  L_0.Phase_ID,
  L_0.Dimensions,
  L_0.Block,
  L_0.Number,
  L_0.Content,
  L_0.Name,
  L_0.NameArabic,
  L_0.PathArabic
FROM (sap_capire_properties_Properties AS L_0 LEFT JOIN sap_capire_properties_Properties_texts AS localized_1 ON localized_1.MapID = L_0.MapID AND localized_1.locale = @locale); 

CREATE VIEW localized_sap_capire_properties_Projects AS SELECT
  L_0.ID,
  L_0.content,
  coalesce(localized_1.name, L_0.name) AS name,
  L_0.image,
  L_0.imageType,
  L_0.nameArabic,
  L_0.description,
  L_0.descriptionArabic
FROM (sap_capire_properties_Projects AS L_0 LEFT JOIN sap_capire_properties_Projects_texts AS localized_1 ON localized_1.ID = L_0.ID AND localized_1.locale = @locale); 

CREATE VIEW localized_sap_capire_properties_ProjectGallery AS SELECT
  L.ID,
  L.image,
  L.imageType,
  L.project_ID
FROM sap_capire_properties_ProjectGallery AS L; 

CREATE VIEW localized_sap_capire_properties_Phases AS SELECT
  L.ID,
  L.project_ID,
  L.name,
  L.nameArabic,
  L.content
FROM sap_capire_properties_Phases AS L; 

CREATE VIEW localized_sap_capire_properties_ERPTable AS SELECT
  L.REFX,
  L.MapID,
  L.Project_ID,
  L.Phase_ID
FROM sap_capire_properties_ERPTable AS L; 

CREATE VIEW localized_sap_capire_properties_PhaseGallery AS SELECT
  L.ID,
  L.image,
  L.imageType,
  L.phase_ID
FROM sap_capire_properties_PhaseGallery AS L; 

CREATE VIEW localized_AdminService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
FROM localized_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_AdminService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content,
  Projects_0.name,
  Projects_0.image,
  Projects_0.imageType,
  Projects_0.nameArabic,
  Projects_0.description,
  Projects_0.descriptionArabic
FROM localized_sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW localized_UserService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
FROM localized_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_UserService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content,
  Projects_0.name,
  Projects_0.image,
  Projects_0.imageType,
  Projects_0.nameArabic,
  Projects_0.description,
  Projects_0.descriptionArabic
FROM localized_sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW localized_AdminService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.name,
  Phases_0.nameArabic,
  Phases_0.content
FROM localized_sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW localized_AdminService_MappingTable AS SELECT
  ERPTable_0.REFX,
  ERPTable_0.MapID,
  ERPTable_0.Project_ID,
  ERPTable_0.Phase_ID
FROM localized_sap_capire_properties_ERPTable AS ERPTable_0; 

CREATE VIEW localized_AdminService_ProjectGallery AS SELECT
  ProjectGallery_0.ID,
  ProjectGallery_0.image,
  ProjectGallery_0.imageType,
  ProjectGallery_0.project_ID
FROM localized_sap_capire_properties_ProjectGallery AS ProjectGallery_0; 

CREATE VIEW localized_UserService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.name,
  Phases_0.nameArabic,
  Phases_0.content
FROM localized_sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW localized_UserService_ProjectGallery AS SELECT
  ProjectGallery_0.ID,
  ProjectGallery_0.image,
  ProjectGallery_0.imageType,
  ProjectGallery_0.project_ID
FROM localized_sap_capire_properties_ProjectGallery AS ProjectGallery_0; 

CREATE VIEW localized_AdminService_PhaseGallery AS SELECT
  PhaseGallery_0.ID,
  PhaseGallery_0.image,
  PhaseGallery_0.imageType,
  PhaseGallery_0.phase_ID
FROM localized_sap_capire_properties_PhaseGallery AS PhaseGallery_0; 

CREATE VIEW localized_UserService_PhaseGallery AS SELECT
  PhaseGallery_0.ID,
  PhaseGallery_0.image,
  PhaseGallery_0.imageType,
  PhaseGallery_0.phase_ID
FROM localized_sap_capire_properties_PhaseGallery AS PhaseGallery_0; 

CREATE VIEW localized_de_sap_capire_properties_Properties AS SELECT
  L_0.createdAt,
  L_0.createdBy,
  L_0.modifiedAt,
  L_0.modifiedBy,
  L_0.REFX,
  L_0.MapID,
  coalesce(localized_de_1.Path, L_0.Path) AS Path,
  L_0.Status,
  L_0.Phase_ID,
  L_0.Dimensions,
  L_0.Block,
  L_0.Number,
  L_0.Content,
  L_0.Name,
  L_0.NameArabic,
  L_0.PathArabic
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
  L_0.Phase_ID,
  L_0.Dimensions,
  L_0.Block,
  L_0.Number,
  L_0.Content,
  L_0.Name,
  L_0.NameArabic,
  L_0.PathArabic
FROM (sap_capire_properties_Properties AS L_0 LEFT JOIN sap_capire_properties_Properties_texts AS localized_fr_1 ON localized_fr_1.MapID = L_0.MapID AND localized_fr_1.locale = @locale); 

CREATE VIEW localized_de_sap_capire_properties_Projects AS SELECT
  L_0.ID,
  L_0.content,
  coalesce(localized_de_1.name, L_0.name) AS name,
  L_0.image,
  L_0.imageType,
  L_0.nameArabic,
  L_0.description,
  L_0.descriptionArabic
FROM (sap_capire_properties_Projects AS L_0 LEFT JOIN sap_capire_properties_Projects_texts AS localized_de_1 ON localized_de_1.ID = L_0.ID AND localized_de_1.locale = @locale); 

CREATE VIEW localized_fr_sap_capire_properties_Projects AS SELECT
  L_0.ID,
  L_0.content,
  coalesce(localized_fr_1.name, L_0.name) AS name,
  L_0.image,
  L_0.imageType,
  L_0.nameArabic,
  L_0.description,
  L_0.descriptionArabic
FROM (sap_capire_properties_Projects AS L_0 LEFT JOIN sap_capire_properties_Projects_texts AS localized_fr_1 ON localized_fr_1.ID = L_0.ID AND localized_fr_1.locale = @locale); 

CREATE VIEW localized_de_sap_capire_properties_ProjectGallery AS SELECT
  L.ID,
  L.image,
  L.imageType,
  L.project_ID
FROM sap_capire_properties_ProjectGallery AS L; 

CREATE VIEW localized_fr_sap_capire_properties_ProjectGallery AS SELECT
  L.ID,
  L.image,
  L.imageType,
  L.project_ID
FROM sap_capire_properties_ProjectGallery AS L; 

CREATE VIEW localized_de_sap_capire_properties_Phases AS SELECT
  L.ID,
  L.project_ID,
  L.name,
  L.nameArabic,
  L.content
FROM sap_capire_properties_Phases AS L; 

CREATE VIEW localized_fr_sap_capire_properties_Phases AS SELECT
  L.ID,
  L.project_ID,
  L.name,
  L.nameArabic,
  L.content
FROM sap_capire_properties_Phases AS L; 

CREATE VIEW localized_de_sap_capire_properties_ERPTable AS SELECT
  L.REFX,
  L.MapID,
  L.Project_ID,
  L.Phase_ID
FROM sap_capire_properties_ERPTable AS L; 

CREATE VIEW localized_fr_sap_capire_properties_ERPTable AS SELECT
  L.REFX,
  L.MapID,
  L.Project_ID,
  L.Phase_ID
FROM sap_capire_properties_ERPTable AS L; 

CREATE VIEW localized_de_sap_capire_properties_PhaseGallery AS SELECT
  L.ID,
  L.image,
  L.imageType,
  L.phase_ID
FROM sap_capire_properties_PhaseGallery AS L; 

CREATE VIEW localized_fr_sap_capire_properties_PhaseGallery AS SELECT
  L.ID,
  L.image,
  L.imageType,
  L.phase_ID
FROM sap_capire_properties_PhaseGallery AS L; 

CREATE VIEW localized_de_AdminService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
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
  Properties_0.Phase_ID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
FROM localized_fr_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_de_AdminService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content,
  Projects_0.name,
  Projects_0.image,
  Projects_0.imageType,
  Projects_0.nameArabic,
  Projects_0.description,
  Projects_0.descriptionArabic
FROM localized_de_sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW localized_fr_AdminService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content,
  Projects_0.name,
  Projects_0.image,
  Projects_0.imageType,
  Projects_0.nameArabic,
  Projects_0.description,
  Projects_0.descriptionArabic
FROM localized_fr_sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW localized_de_UserService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
FROM localized_de_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_fr_UserService_Properties AS SELECT
  Properties_0.createdAt,
  Properties_0.createdBy,
  Properties_0.modifiedAt,
  Properties_0.modifiedBy,
  Properties_0.REFX,
  Properties_0.MapID,
  Properties_0.Path,
  Properties_0.Status,
  Properties_0.Phase_ID,
  Properties_0.Dimensions,
  Properties_0.Block,
  Properties_0.Number,
  Properties_0.Content,
  Properties_0.Name,
  Properties_0.NameArabic,
  Properties_0.PathArabic
FROM localized_fr_sap_capire_properties_Properties AS Properties_0; 

CREATE VIEW localized_de_UserService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content,
  Projects_0.name,
  Projects_0.image,
  Projects_0.imageType,
  Projects_0.nameArabic,
  Projects_0.description,
  Projects_0.descriptionArabic
FROM localized_de_sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW localized_fr_UserService_Projects AS SELECT
  Projects_0.ID,
  Projects_0.content,
  Projects_0.name,
  Projects_0.image,
  Projects_0.imageType,
  Projects_0.nameArabic,
  Projects_0.description,
  Projects_0.descriptionArabic
FROM localized_fr_sap_capire_properties_Projects AS Projects_0; 

CREATE VIEW localized_de_AdminService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.name,
  Phases_0.nameArabic,
  Phases_0.content
FROM localized_de_sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW localized_fr_AdminService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.name,
  Phases_0.nameArabic,
  Phases_0.content
FROM localized_fr_sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW localized_de_AdminService_MappingTable AS SELECT
  ERPTable_0.REFX,
  ERPTable_0.MapID,
  ERPTable_0.Project_ID,
  ERPTable_0.Phase_ID
FROM localized_de_sap_capire_properties_ERPTable AS ERPTable_0; 

CREATE VIEW localized_fr_AdminService_MappingTable AS SELECT
  ERPTable_0.REFX,
  ERPTable_0.MapID,
  ERPTable_0.Project_ID,
  ERPTable_0.Phase_ID
FROM localized_fr_sap_capire_properties_ERPTable AS ERPTable_0; 

CREATE VIEW localized_de_AdminService_ProjectGallery AS SELECT
  ProjectGallery_0.ID,
  ProjectGallery_0.image,
  ProjectGallery_0.imageType,
  ProjectGallery_0.project_ID
FROM localized_de_sap_capire_properties_ProjectGallery AS ProjectGallery_0; 

CREATE VIEW localized_fr_AdminService_ProjectGallery AS SELECT
  ProjectGallery_0.ID,
  ProjectGallery_0.image,
  ProjectGallery_0.imageType,
  ProjectGallery_0.project_ID
FROM localized_fr_sap_capire_properties_ProjectGallery AS ProjectGallery_0; 

CREATE VIEW localized_de_UserService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.name,
  Phases_0.nameArabic,
  Phases_0.content
FROM localized_de_sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW localized_fr_UserService_Phases AS SELECT
  Phases_0.ID,
  Phases_0.project_ID,
  Phases_0.name,
  Phases_0.nameArabic,
  Phases_0.content
FROM localized_fr_sap_capire_properties_Phases AS Phases_0; 

CREATE VIEW localized_de_UserService_ProjectGallery AS SELECT
  ProjectGallery_0.ID,
  ProjectGallery_0.image,
  ProjectGallery_0.imageType,
  ProjectGallery_0.project_ID
FROM localized_de_sap_capire_properties_ProjectGallery AS ProjectGallery_0; 

CREATE VIEW localized_fr_UserService_ProjectGallery AS SELECT
  ProjectGallery_0.ID,
  ProjectGallery_0.image,
  ProjectGallery_0.imageType,
  ProjectGallery_0.project_ID
FROM localized_fr_sap_capire_properties_ProjectGallery AS ProjectGallery_0; 

CREATE VIEW localized_de_AdminService_PhaseGallery AS SELECT
  PhaseGallery_0.ID,
  PhaseGallery_0.image,
  PhaseGallery_0.imageType,
  PhaseGallery_0.phase_ID
FROM localized_de_sap_capire_properties_PhaseGallery AS PhaseGallery_0; 

CREATE VIEW localized_fr_AdminService_PhaseGallery AS SELECT
  PhaseGallery_0.ID,
  PhaseGallery_0.image,
  PhaseGallery_0.imageType,
  PhaseGallery_0.phase_ID
FROM localized_fr_sap_capire_properties_PhaseGallery AS PhaseGallery_0; 

CREATE VIEW localized_de_UserService_PhaseGallery AS SELECT
  PhaseGallery_0.ID,
  PhaseGallery_0.image,
  PhaseGallery_0.imageType,
  PhaseGallery_0.phase_ID
FROM localized_de_sap_capire_properties_PhaseGallery AS PhaseGallery_0; 

CREATE VIEW localized_fr_UserService_PhaseGallery AS SELECT
  PhaseGallery_0.ID,
  PhaseGallery_0.image,
  PhaseGallery_0.imageType,
  PhaseGallery_0.phase_ID
FROM localized_fr_sap_capire_properties_PhaseGallery AS PhaseGallery_0; 

