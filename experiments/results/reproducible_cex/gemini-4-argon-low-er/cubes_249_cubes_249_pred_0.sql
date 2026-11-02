-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('T1', 'Type 1');
INSERT INTO "Templates" ("Template_ID", "Template_Type_Code", "Version_Number", "Date_Effective_From", "Date_Effective_To", "Template_Details") VALUES (1, 'T1', 1, '2020-01-01', '2020-12-31', 'Details');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (1, 1, 'Doc 1', 'Desc 1', 'Other 1');
INSERT INTO "Documents" ("Document_ID", "Template_ID", "Document_Name", "Document_Description", "Other_Details") VALUES (2, 1, 'Doc 2', 'Desc 2', 'Other 2');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (1, 1, 'P1', 'O1');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (2, 1, 'P2', 'O2');
INSERT INTO "Paragraphs" ("Paragraph_ID", "Document_ID", "Paragraph_Text", "Other_Details") VALUES (3, 2, 'P3', 'O3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id FROM (SELECT * FROM (SELECT * FROM (SELECT paragraph_id, document_id, paragraph_text, other_details, COUNT(*) OVER () AS n FROM paragraphs) ORDER BY document_id) LIMIT 1);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT document_id FROM Paragraphs GROUP BY document_id ORDER BY COUNT(*) ASC, document_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2,)
*/