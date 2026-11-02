-- Schema DDL
CREATE TABLE "Ref_Document_Types" ("Document_Type_Code" TEXT(15) PRIMARY KEY, "Document_Type_Name" TEXT(255), "Document_Type_Description" TEXT(255));

CREATE TABLE "Ref_Budget_Codes" ("Budget_Type_Code" TEXT(15) PRIMARY KEY, "Budget_Type_Description" TEXT(255));

CREATE TABLE "Projects" ("Project_ID" INTEGER PRIMARY KEY, "Project_Details" TEXT(255));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Project_ID" INTEGER, "Document_Type_Code" TEXT(15), "Document_Date" DATETIME, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Project_ID") REFERENCES "Projects" ("Project_ID"), FOREIGN KEY ("Document_Type_Code") REFERENCES "Ref_Document_Types" ("Document_Type_Code"));

CREATE TABLE "Statements" ("Statement_ID" INTEGER PRIMARY KEY, "Statement_Details" TEXT(255), FOREIGN KEY ("Statement_ID") REFERENCES "Documents" ("Document_ID"));

CREATE TABLE "Documents_with_Expenses" ("Document_ID" INTEGER PRIMARY KEY, "Budget_Type_Code" TEXT(15), "Document_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"), FOREIGN KEY ("Budget_Type_Code") REFERENCES "Ref_Budget_Codes" ("Budget_Type_Code"));

CREATE TABLE "Accounts" ("Account_ID" INTEGER PRIMARY KEY, "Statement_ID" INTEGER, "Account_Details" TEXT(255), FOREIGN KEY ("Statement_ID") REFERENCES "Statements" ("Statement_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "projects" ("project_id", "project_details") VALUES (1016, 'food');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1017, 'education');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1018, 'article');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1019, 'effect');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1024, 'hundred');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1025, 'able');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1026, 'in');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1027, 'evidence');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('unit', 'John Jones', 'Sense ready require human public health tonight.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('our', 'Pamela Anderson', 'Building different full open discover detail audience.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('your', 'Joshua Baker', 'Arrive attack all form method everything magazine much.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('bar', 'Jenny Lewis', 'Office drug list imagine behind probably great.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('with', 'Michael Cross', 'Once me system.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('step', 'Mary Tucker', 'Arm meet surface attention.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('still', 'Daniel Brown', 'Push dog build three.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('look', 'Amy Edwards', 'Often always bank price north.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1020, 1016, 'unit', '1977-08-08', 'Scott Brown', 'Art rock song body.', 'institution');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1021, 1016, 'unit', '1977-08-09', 'Scott Brown', 'Couple large instead everything economic.', 'weight');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1022, 1016, 'unit', '1977-08-10', 'Scott Brown', 'Kitchen technology nearly anything.', 'artist');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1023, 1016, 'unit', '1977-08-11', 'Scott Brown', 'Structure why unit support coach magazine degree.', 'community');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1028, 1024, 'with', '1981-01-12', 'Dean Santiago', 'Draw how public feel first sell.', 'record');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1029, 1024, 'with', '1981-01-13', 'Dean Santiago', 'Act perform none beyond.', 'body');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1030, 1024, 'with', '1981-01-14', 'Dean Santiago', 'Defense enter value thing these hard citizen.', 'wrong');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1031, 1024, 'with', '1981-01-15', 'Dean Santiago', 'Region particularly would pressure account stage federal.', 'center');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id FROM (SELECT * FROM (SELECT * FROM (SELECT document_name, project_id, COUNT(*) AS n FROM documents GROUP BY document_name, project_id) ORDER BY project_id DESC) LIMIT 1);

/*
Gold Result:
(1024,)
*/

-- Prediction Query
SELECT project_id FROM Documents GROUP BY project_id ORDER BY COUNT(*) ASC, project_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(1016,)
*/