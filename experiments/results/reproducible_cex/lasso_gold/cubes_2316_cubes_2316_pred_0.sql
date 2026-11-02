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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1014, 'attack');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1015, 'image');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1016, 'I');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1020, 'attack');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1021, 'attack');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('pick', 'Juan Dunlap', 'Itself law west then enjoy.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('management', 'Ashley Dyer', 'Seven medical blood personal success medical current.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('newspaper', 'Patricia Peterson', 'Several much single morning a food.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('remain', 'Joseph Martinez', 'Arrive attack all form method everything magazine much.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('rate', 'George Chapman', 'Office drug list imagine behind probably great.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('hour', 'Daniel Jones', 'Level rock pull worker better I.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1017, 1014, 'pick', '1976-07-07', 'Timothy Koch', 'Staff within mouth call process water close.', 'news');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1018, 1014, 'pick', '1976-07-08', 'Elizabeth Brown', 'Staff within mouth call process water close.', 'turn');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1019, 1014, 'pick', '1976-07-09', 'Theresa Miller', 'Staff within mouth call process water close.', 'policy');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1022, 1014, 'remain', '1979-10-10', 'Scott Wright', 'Who up sense ready require human.', 'level');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1023, 1014, 'remain', '1979-10-11', 'Jerry Henderson', 'Who up sense ready require human.', 'system');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1024, 1014, 'remain', '1979-10-12', 'David Leblanc', 'Who up sense ready require human.', 'training');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1025, 1014, 'remain', '1979-10-12', 'David Leblanc', 'Who up sense ready require human.', 'training');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT project_id, project_details FROM (SELECT LHS.project_id AS project_id, LHS.project_details AS project_details, RHS.document_description AS document_description, RHS.n AS n FROM projects AS LHS INNER JOIN (SELECT document_description, project_id, COUNT(*) AS n FROM documents GROUP BY document_description, project_id) AS RHS ON (LHS.project_id = RHS.project_id)) WHERE (n >= 2) ORDER BY project_id, project_details NULLS LAST;

/*
Gold Result:
(1014, 'attack')
(1014, 'attack')
*/

-- Prediction Query
SELECT T1.project_id, T1.project_details FROM Projects AS T1 JOIN Documents AS T2 ON T1.project_id = T2.project_id GROUP BY T1.project_id HAVING COUNT(*) > 2;

/*
Prediction Result:
(1014, 'attack')
*/