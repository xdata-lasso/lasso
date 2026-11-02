-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ordering where minimum Document_ID does not correspond to minimum Paragraph_ID, and frequency counts vary (1 vs 2 vs 3) to kill group-by/count mutants and DESC/LIMIT mutants.
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T1', 'Type 1');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'T1', 1, '2020-01-01', '2025-01-01', 'Details');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (10, 1, 'Doc 10', 'Desc 10', 'Other');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (20, 1, 'Doc 20', 'Desc 20', 'Other');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (30, 1, 'Doc 30', 'Desc 30', 'Other');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (40, 1, 'Doc 40', 'Desc 40', 'Other');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (1, 30, 'AAA', 'Z');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (2, 20, 'BBB', 'Y');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (3, 20, 'CCC', 'X');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (4, 10, 'DDD', 'W');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (5, 10, 'EEE', 'V');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (6, 10, 'FFF', 'U');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id FROM (SELECT * FROM (SELECT * FROM (SELECT paragraph_id, document_id, paragraph_text, other_details, COUNT(*) OVER () AS n FROM paragraphs) ORDER BY document_id) LIMIT 1);

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT document_id FROM Paragraphs GROUP BY document_id ORDER BY COUNT(*) ASC, document_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(30,)
*/