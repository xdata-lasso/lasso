-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (10, '2023-01-15', 'Science', 500);
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (20, '2023-02-20', 'Technology', 800);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (1, 'Zack', 20.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (2, 'Alice', 50.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (3, 'Bob', 30.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (4, 'Charlie', 40.0);
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (3, 10, 'Review');
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (3, 20, 'Edit');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM editor AS LHS WHERE NOT EXISTS(SELECT 1 FROM journal_committee AS RHS WHERE (LHS.editor_id = RHS.editor_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM editor WHERE NOT editor_id IN (SELECT editor_id FROM journal_committee);

/*
Prediction Result:
('Zack',)
('Alice',)
('Charlie',)
*/