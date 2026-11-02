-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('BK', 'Drive note bad rule.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1028, 'BK', 1029, '1988-08-19', '1989-09-20', 'team');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1034, 'BK', 1035, '1992-01-23', '1993-02-01', 'give');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1030, 1028, 'Philip Cannon', 'Process water close month.', 'policy');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1033, 1028, 'Jessica Holmes', 'Easy ask again network.', 'per');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1036, 1034, 'David Caldwell', 'Much rich think office drug.', 'material');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "document_name" FROM (SELECT * FROM "documents" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "templates" WHERE ("template_type_code" <> 'BK')) AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY document_name, "document_name" NULLS LAST;

/*
Gold Result:
('David Caldwell',)
('Jessica Holmes',)
('Philip Cannon',)
*/

-- Prediction Query
SELECT T2.document_name FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id WHERE T1.template_type_code = 'BK';

/*
Prediction Result:
('Philip Cannon',)
('Jessica Holmes',)
('David Caldwell',)
*/