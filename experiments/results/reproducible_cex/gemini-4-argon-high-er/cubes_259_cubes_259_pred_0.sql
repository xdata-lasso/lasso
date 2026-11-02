-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T1', 'Type 1');
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T2', 'Type 2');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'T1', 1, '2020-01-01 00:00:00', '2020-12-31 00:00:00', 'Details 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (2, 'T2', 1, '2021-01-01 00:00:00', '2021-12-31 00:00:00', 'Details 2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT template_type_code FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM templates AS LHS WHERE NOT EXISTS(SELECT 1 FROM documents AS RHS WHERE (LHS.template_id = RHS.template_id))) ORDER BY date_effective_from DESC) LIMIT 1);

/*
Gold Result:
('T2',)
*/

-- Prediction Query
SELECT template_type_code FROM Templates EXCEPT SELECT template_type_code FROM Templates AS T1 JOIN Documents AS T2 ON T1.template_id = T2.template_id;

/*
Prediction Result:
('T1',)
('T2',)
*/