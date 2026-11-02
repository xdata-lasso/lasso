-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('surface', 'By two bad fall pick those gun.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('animal', 'Relate animal direction eye bag.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('show', 'Term herself law street class.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('machine', 'Decide environment view possible participant commercial.');
INSERT INTO "ref_template_types" ("template_type_code", "template_type_description") VALUES ('hundred', 'Writer policy news range successful.');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1009, 'surface', 1013, '1978-09-09', '1982-02-13', 'shoulder');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1010, 'surface', 1020.0, '1978-09-10', '1982-02-14', 'election');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1011, 'surface', 1027.0, '1978-09-11', '1982-02-15', 'common');
INSERT INTO "templates" ("template_id", "template_type_code", "version_number", "date_effective_from", "date_effective_to", "template_details") VALUES (1012, 'surface', 1034.0, '1978-09-12', '1982-02-16', 'maintain');
INSERT INTO "documents" ("document_id", "template_id", "document_name", "document_description", "other_details") VALUES (1018, 1009, 'Rodney Trujillo', 'Environment decision wall then fire pretty.', 'individual');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM templates AS LHS WHERE NOT EXISTS(SELECT 1 FROM documents AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY date_effective_from DESC) LIMIT 1);

/*
Gold Result:
('surface',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates EXCEPT SELECT template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id;

/*
Prediction Result:
*/