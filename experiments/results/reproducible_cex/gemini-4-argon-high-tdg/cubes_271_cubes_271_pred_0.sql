-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('T1', 'Standard Template');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (1, 'T1', 1, '2020-01-01 00:00:00', '2025-01-01 00:00:00', 'Details 1');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (1, 1, 'Customer reviews', 'First review doc', 'Doc 1');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (2, 1, 'Annual report', 'Report doc', 'Doc 2');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (3, 1, 'Customer reviews', 'Second review doc', 'Doc 3');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (4, 1, 'User manual', 'Manual doc', 'Doc 4');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (1, 1, 'Zeta feedback', 'Detail A');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (2, 2, 'Hidden report text', 'Detail B');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (3, 1, 'Alpha comment', 'Detail C');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (4, 3, 'Beta review', 'Detail D');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (5, 3, 'Alpha comment', 'Detail E');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (6, 4, 'Manual instructions', 'Detail F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "paragraph_text" FROM (SELECT * FROM "paragraphs" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "documents" WHERE ("document_name" <> 'Customer reviews')) AS RHS WHERE (LHS.document_id = RHS.document_id))) ORDER BY paragraph_text, "paragraph_text" NULLS LAST;

/*
Gold Result:
('Alpha comment',)
('Alpha comment',)
('Beta review',)
('Zeta feedback',)
*/

-- Prediction Query
SELECT T1.paragraph_text FROM Paragraphs AS T1 JOIN Documents AS T2 ON T1.document_id = T2.document_id WHERE T2.document_name = 'Customer reviews';

/*
Prediction Result:
('Zeta feedback',)
('Alpha comment',)
('Beta review',)
('Alpha comment',)
*/