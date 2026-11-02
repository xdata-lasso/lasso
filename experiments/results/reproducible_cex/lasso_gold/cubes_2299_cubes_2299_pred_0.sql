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
INSERT INTO "projects" ("project_id", "project_details") VALUES (1009, 'character');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1010, 'evidence');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1011, 'chair');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1012, 'employee');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1033, 'treatment');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1034, 'commercial');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1035, 'such');
INSERT INTO "projects" ("project_id", "project_details") VALUES (1036, 'talk');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('size', 'Jessica Silva', 'High you more wife team activity.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('option', 'Zachary Taylor', 'Race Mr environment political.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('nothing', 'Peter Callahan Jr.', 'Fall citizen about reveal.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('everyone', 'Michael Carlson', 'Will seven medical blood personal.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('cost', 'Tim Patton', 'Staff least figure somebody dinner.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('upon', 'Michael Moss', 'Process huge everything.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('itself', 'Christopher Haynes', 'Whom evidence political hundred.');
INSERT INTO "ref_document_types" ("document_type_code", "document_type_name", "document_type_description") VALUES ('ago', 'Andrew Ruiz', 'Former agree theory end oil worker although.');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1013, 1009, 'size', '1974-05-05', 'Katie Gonzalez', 'Dream drive note bad rule.', 'end');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1014, 1009, 'size', '1974-05-06', 'Christopher Ashley', 'Within mouth call process.', 'down');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1015, 1009, 'size', '1974-05-07', 'Tamara George', 'Close month parent who up sense ready.', 'attack');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1016, 1009, 'size', '1974-05-08', 'Brian Cox DVM', 'Human public health tonight later.', 'ground');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1037, 1033, NULL, '1986-06-17', 'Haley Hartman', 'Hair attorney professional form finish.', 'few');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1038, 1033, NULL, '1986-06-18', 'William Wilson', 'Rest feel finally impact.', 'develop');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1039, 1033, NULL, '1986-06-19', 'Cheryl Williams', 'Recent never court professor here security.', 'law');
INSERT INTO "documents" ("document_id", "project_id", "document_type_code", "document_date", "document_name", "document_description", "other_details") VALUES (1040, 1033, NULL, '1986-06-20', 'Joseph Drake', 'Past feeling nature a.', 'stock');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT document_type_code, other_details, COUNT(*) AS n FROM documents GROUP BY document_type_code, other_details) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT document_type_code FROM Documents GROUP BY document_type_code ORDER BY COUNT(*) DESC, document_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('size',)
*/