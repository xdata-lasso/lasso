-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests empty Templates table behavior (window function over 0 rows returns 0 rows vs scalar aggregate COUNT(*) which returns 1 row with 0).
INSERT INTO "Ref_Template_Types" ("Template_Type_Code", "Template_Type_Description") VALUES ('T1', 'Standard Template');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM templates ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM Templates;

/*
Prediction Result:
(0,)
*/