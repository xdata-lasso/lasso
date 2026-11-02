-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Alice', NULL);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Alice', 25.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, NULL, 45.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (4, NULL, 30.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age FROM editor ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
(None, 45.0)
(None, 30.0)
('Alice', None)
('Alice', 25.5)
*/

-- Prediction Query
SELECT Name, Age FROM editor;

/*
Prediction Result:
('Alice', None)
('Alice', 25.5)
(None, 45.0)
(None, 30.0)
*/