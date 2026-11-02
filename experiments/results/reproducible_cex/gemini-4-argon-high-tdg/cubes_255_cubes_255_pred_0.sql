-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (50, NULL, 1, '2021-01-01', '2022-01-01', 'Null Type Template');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (5, NULL, 'Doc_Without_Template', NULL, NULL);
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (6, 50, 'Doc_With_Null_Type_Template', 'Desc 6', 'Other 6');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (201, NULL, 'Orphan Paragraph 1', 'Orphan Detail 1');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (202, NULL, 'Orphan Paragraph 2', 'Orphan Detail 2');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (203, 5, 'Paragraph for Doc 5', 'Detail 5');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (204, 6, 'Paragraph 1 for Doc 6', 'Detail 6A');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (205, 6, 'Paragraph 2 for Doc 6', 'Detail 6B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id, document_name, n AS count___ FROM (SELECT LHS.document_id AS document_id, LHS.n AS n, RHS.template_id AS template_id, RHS.document_name AS document_name, RHS.document_description AS document_description, RHS.other_details AS other_details FROM (SELECT document_id, COUNT(*) AS n FROM paragraphs GROUP BY document_id) AS LHS LEFT JOIN documents AS RHS ON (LHS.document_id = RHS.document_id)) ORDER BY document_id, document_name NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, None, 2)
(5, 'Doc_Without_Template', 1)
(6, 'Doc_With_Null_Type_Template', 2)
*/

-- Prediction Query
SELECT T1.document_id, T2.document_name, COUNT(*) FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id GROUP BY T1.document_id;

/*
Prediction Result:
(5, 'Doc_Without_Template', 1)
(6, 'Doc_With_Null_Type_Template', 2)
*/