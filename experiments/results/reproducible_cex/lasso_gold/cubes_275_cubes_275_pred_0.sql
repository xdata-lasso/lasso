-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('sound', 'Medical blood personal success.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('turn', 'Institution deep much role cut find yet practice.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1027, 'sound', 1028, '1986-06-17', '1987-07-18', 'movement');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1033, 'turn', 1034, '1990-10-21', '1991-11-22', 'left');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1029, 1027, 'Data base', 'Current hear claim well two truth out major.', 'brother');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1032, 1027, 'Data base', 'Staff within mouth call process water close.', 'news');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1035, 1033, 'Data base', 'Later easy ask again network open according.', 'second');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "template_type_code" FROM (SELECT * FROM "templates" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" = 'Data base')) AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY template_type_code, "template_type_code" NULLS LAST;

/*
Gold Result:
('sound',)
('turn',)
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id WHERE T2.document_name = 'Data base';

/*
Prediction Result:
('sound',)
('sound',)
('turn',)
*/