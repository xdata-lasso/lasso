-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (1, '2020-01-01', 'Science', 100);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (1, 'Bob', 30.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (2, 'Alice', 25.0);
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (NULL, 1, 'Review');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM editor AS LHS WHERE NOT EXISTS(SELECT 1 FROM journal_committee AS RHS WHERE (LHS.editor_id = RHS.editor_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM editor WHERE NOT editor_id IN (SELECT editor_id FROM journal_committee);

/*
Prediction Result:
*/