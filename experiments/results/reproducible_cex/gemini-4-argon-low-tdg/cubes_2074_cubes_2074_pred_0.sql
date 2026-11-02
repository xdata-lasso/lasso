-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (10, 'Charlie', 40.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (20, 'Alice', 35.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (5, 'Alice', 28.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (15, 'Bob', 50.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age FROM editor ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
('Alice', 28.0)
('Alice', 35.5)
('Bob', 50.0)
('Charlie', 40.0)
*/

-- Prediction Query
SELECT Name, Age FROM editor;

/*
Prediction Result:
('Alice', 28.0)
('Charlie', 40.0)
('Bob', 50.0)
('Alice', 35.5)
*/