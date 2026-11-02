-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('T1', 'Type 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'T1', 1, '2020-01-01', '2025-01-01', 'Details');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 1, 'Summer Show', 'Desc', 'Other');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (1, 1, 'Text', 'Other');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "LHS"."paragraph_id" AS "paragraph_id", "LHS"."document_id" AS "document_id", "LHS"."paragraph_text" AS "paragraph_text", "LHS"."other_details" AS "other_details", "RHS"."document_name" AS "document_name", "RHS"."n" AS "n" FROM "paragraphs" AS "LHS" LEFT JOIN (SELECT "document_id", "document_name", COUNT(*) AS "n" FROM "documents" GROUP BY "document_id", "document_name") AS "RHS" ON ("LHS"."document_id" = "RHS"."document_id")) WHERE ("document_name" <> 'Summer Show') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_ID = T2.document_ID WHERE T2.document_name = 'Summer Show';

/*
Prediction Result:
(1,)
*/