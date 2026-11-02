-- Schema DDL
CREATE TABLE "Ref_Template_Types" ("Template_Type_Code" TEXT(15) PRIMARY KEY, "Template_Type_Description" TEXT(255));

CREATE TABLE "Templates" ("Template_ID" INTEGER PRIMARY KEY, "Template_Type_Code" TEXT(15), "Version_Number" INTEGER, "Date_Effective_From" DATETIME, "Date_Effective_To" DATETIME, "Template_Details" TEXT(255), FOREIGN KEY ("Template_Type_Code") REFERENCES "Ref_Template_Types" ("Template_Type_Code"));

CREATE TABLE "Documents" ("Document_ID" INTEGER PRIMARY KEY, "Template_ID" INTEGER, "Document_Name" TEXT(255), "Document_Description" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Template_ID") REFERENCES "Templates" ("Template_ID"));

CREATE TABLE "Paragraphs" ("Paragraph_ID" INTEGER PRIMARY KEY, "Document_ID" INTEGER, "Paragraph_Text" TEXT(255), "Other_Details" TEXT(255), FOREIGN KEY ("Document_ID") REFERENCES "Documents" ("Document_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Ref_Template_Types (Template_Type_Code, Template_Type_Description) VALUES ('RPT', 'Report');
INSERT INTO Templates (Template_ID, Template_Type_Code, Version_Number, Date_Effective_From, Date_Effective_To, Template_Details) VALUES (201, 'RPT', 1, '2019-05-01 00:00:00', '2029-05-01 00:00:00', 'Report Template');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (15, 201, 'First Active Doc', 'Has most paragraphs', 'D15');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (25, 201, 'Second Active Doc', 'Has fewest paragraphs', 'D25');
INSERT INTO Documents (Document_ID, Template_ID, Document_Name, Document_Description, Other_Details) VALUES (35, 201, 'Third Active Doc', 'Has two paragraphs', 'D35');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (501, 25, 'First inserted paragraph', 'P1');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (502, 15, 'Second inserted paragraph', 'P2');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (503, 15, 'Third inserted paragraph', 'P3');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (504, 15, 'Fourth inserted paragraph', 'P4');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (505, 35, 'Fifth inserted paragraph', 'P5');
INSERT INTO Paragraphs (Paragraph_ID, Document_ID, Paragraph_Text, Other_Details) VALUES (506, 35, 'Sixth inserted paragraph', 'P6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT document_id FROM (SELECT * FROM (SELECT * FROM (SELECT paragraph_id, document_id, paragraph_text, other_details, COUNT(*) OVER () AS n FROM paragraphs) ORDER BY document_id) LIMIT 1);

/*
Gold Result:
(15,)
*/

-- Prediction Query
SELECT document_id FROM Paragraphs GROUP BY document_id ORDER BY COUNT(*) ASC, document_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(25,)
*/