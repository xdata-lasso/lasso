-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('purpose', 'Agent every development say.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('sense', 'Agent every development say.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1001, 'purpose', 1002, '1970-01-01', '1971-02-02', 'require');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1005, 'purpose', 1002, '1970-01-01', '1971-02-02', 'require');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1003, 1001, 'Kimberly Garza', 'Ahead despite measure.', 'agreement');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1007, 1001, 'Kimberly Garza', 'Ahead despite measure.', 'agreement');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1004, 1003, 'option', 'decide');
INSERT INTO "paragraphs" ("paragraph_id", "document_id", "paragraph_text", "other_details") VALUES (1008, NULL, 'option', 'decide');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id, document_name, n AS count___ FROM (SELECT LHS.document_id AS document_id, LHS.n AS n, RHS.template_id AS template_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM (SELECT document_id, COUNT(*) AS n FROM paragraphs GROUP BY document_id) AS LHS LEFT JOIN documents AS RHS ON (LHS.document_id = RHS.document_id)) ORDER BY document_id, document_name NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, None, 1)
(1003, 'Kimberly Garza', 1)
*/

-- Prediction Query
SELECT T1.document_id, T2.document_name, COUNT(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id GROUP BY T1.document_id;

/*
Prediction Result:
(1003, 'Kimberly Garza', 1)
*/