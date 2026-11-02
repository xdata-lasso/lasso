-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. COUNT(DISTINCT template_id) vs COUNT(template_id) vs COUNT(*)
-- 2. Handling of NULL in template_id (producing a 0 count group)
-- 3. Handling of NULL in the GROUP BY column (other_details)
-- 4. Duplicate count values across different groups (testing outer SELECT DISTINCT vs SELECT ALL)
-- 5. Ordering of results (ORDER BY ASC vs DESC vs no order)
-- 6. Grouping by other_details vs Document_Name or Document_Description
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T1', 'Type 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'T1', 1, '2020-01-01', '2021-01-01', 'Details 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'T1', 1, '2020-01-01', '2021-01-01', 'Details 2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (3, 'T1', 1, '2020-01-01', '2021-01-01', 'Details 3');
-- Group 'D_Three' (inserted first to break insertion-order correlation with count): 3 distinct templates
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (1, 1, 'SameName', 'Desc1', 'D_Three');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (2, 2, 'SameName', 'Desc2', 'D_Three');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (3, 3, 'DiffName', 'Desc3', 'D_Three');
-- Group 'D_One_Dup': 2 rows, 1 distinct template (catches missing DISTINCT inside COUNT)
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (4, 1, 'SameName', 'Desc4', 'D_One_Dup');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (5, 1, 'DiffName', 'Desc4', 'D_One_Dup');
-- Group 'D_Zero': 1 row with NULL template_id (catches COUNT(*) vs COUNT(template_id), and inner join to Templates)
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (6, NULL, 'Name6', 'Desc6', 'D_Zero');
-- Group 'D_One_Single': 1 row, 1 distinct template (produces duplicate count '1' in outer query, catching outer SELECT DISTINCT)
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (7, 2, 'Name7', 'Desc7', 'D_One_Single');
-- Group NULL: 2 distinct templates + 1 NULL template_id (tests NULL group key handling)
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (8, 1, 'Name8', 'Desc8', NULL);
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (9, 2, 'Name9', 'Desc9', NULL);
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (10, NULL, 'Name10', 'Desc10', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n_distinct AS count_distinct_template_id_ FROM (SELECT other_details, COUNT(DISTINCT template_id) AS n_distinct FROM documents GROUP BY other_details) ORDER BY count_distinct_template_id_;

/*
Gold Result:
(0,)
(1,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT template_id) FROM Documents;

/*
Prediction Result:
(3,)
*/