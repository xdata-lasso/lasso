-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join (filtering out the most recent template because it has a document),
-- ORDER BY date_effective_from DESC vs ASC, and LIMIT 1 vs no limit.
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TYPE_A', 'Desc A');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TYPE_B', 'Desc B');
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('TYPE_C', 'Desc C');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'TYPE_A', 3, '2025-01-01 00:00:00', '2020-01-01 00:00:00', 'Has documents, latest date');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (2, 'TYPE_B', 1, '2023-01-01 00:00:00', '2021-01-01 00:00:00', 'No documents, middle date (Target)');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (3, 'TYPE_C', 2, '2021-01-01 00:00:00', '2026-01-01 00:00:00', 'No documents, earliest date');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (10, 1, 'Doc 1', 'Desc', 'Other');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (11, 1, 'Doc 2', 'Desc', 'Other');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM templates AS LHS WHERE NOT EXISTS(SELECT 1 FROM documents AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY date_effective_from DESC) LIMIT 1);

/*
Gold Result:
('TYPE_B',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates EXCEPT SELECT template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id;

/*
Prediction Result:
('TYPE_B',)
('TYPE_C',)
*/