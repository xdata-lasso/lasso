-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('purpose', 'Agent every development say.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1, 'purpose', 1001, '1970-01-01', '1971-02-02', 'require');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1002, 'purpose', 1003, '1972-03-03', '1973-04-04', 'sit');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1004, 1, 'Angie Henderson', 'Behavior discussion own.', 'option');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details, LHS.n AS n, RHS.document_id AS document_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM (SELECT template_id, version_number, template_type_code, date_effective_from, date_effective_to, template_details, template_id AS n FROM (SELECT LHS.template_id AS template_id, LHS.version_number AS version_number, LHS.template_type_code AS template_type_code, LHS.date_effective_from AS date_effective_from, LHS.date_effective_to AS date_effective_to, LHS.template_details AS template_details FROM templates AS LHS INNER JOIN (SELECT COUNT(*) AS n FROM templates) AS RHS ON (LHS.template_id = RHS.n))) AS LHS INNER JOIN documents AS RHS ON (LHS.template_id = RHS.template_id)) ORDER BY template_type_code;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id GROUP BY T1.template_type_code ORDER BY COUNT(*) DESC, T1.template_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('purpose',)
*/