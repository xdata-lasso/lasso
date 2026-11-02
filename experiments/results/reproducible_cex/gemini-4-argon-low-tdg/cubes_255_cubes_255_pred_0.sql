-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('T1', 'Type 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'T1', 1, '2020-01-01 00:00:00', '2021-01-01 00:00:00', 'Details 1');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 1, 'DocOne', 'Desc 1', 'Other 1');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (1, NULL, 'Orphan 1', 'Other');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (2, NULL, NULL, NULL);
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (3, 1, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id, document_name, n AS count___ FROM (SELECT LHS.document_id AS document_id, LHS.n AS n, RHS.template_id AS template_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM (SELECT document_id, COUNT(*) AS n FROM paragraphs GROUP BY document_id) AS LHS LEFT JOIN documents AS RHS ON (LHS.document_id = RHS.document_id)) ORDER BY document_id, document_name NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, None, 2)
(1, 'DocOne', 1)
*/

-- Prediction Query
SELECT T1.document_id, T2.document_name, COUNT(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id GROUP BY T1.document_id;

/*
Prediction Result:
(1, 'DocOne', 1)
*/