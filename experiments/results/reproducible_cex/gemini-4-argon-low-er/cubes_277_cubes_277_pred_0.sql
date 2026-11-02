-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T1', 'Type 1');
INSERT INTO Templates (Template_ID, Template_Type_Code) VALUES (1, 'T1');
INSERT INTO Documents (Document_ID, Template_ID, Other_Details) VALUES (1, 1, 'A');
INSERT INTO Documents (Document_ID, Template_ID, Other_Details) VALUES (2, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_template_id_ FROM (SELECT other_details, COUNT(DISTINCT template_id) AS n_distinct FROM documents GROUP BY other_details) ORDER BY count_distinct_template_id_;

/*
Gold Result:
(1,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT template_id) FROM Documents;

/*
Prediction Result:
(1,)
*/