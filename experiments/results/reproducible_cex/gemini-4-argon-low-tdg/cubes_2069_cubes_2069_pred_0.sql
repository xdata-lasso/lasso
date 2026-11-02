-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions (24.0 and 25.0), strictly inside (REAL/fractional values), strictly outside, and NULL age.
INSERT INTO editor (Editor_ID, Name, Age) VALUES (1, 'Alice', 23.9);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (2, 'Bob', 24.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (3, 'Charlie', 24.5);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (4, 'David', 25.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (5, 'Eve', 25.1);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (6, 'Frank', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM editor WHERE (age >= 24.0 AND age <= 25.0) ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
('Bob',)
('Charlie',)
('David',)
*/

-- Prediction Query
SELECT Name FROM editor WHERE Age = 24 OR Age = 25;

/*
Prediction Result:
('Bob',)
('David',)
*/