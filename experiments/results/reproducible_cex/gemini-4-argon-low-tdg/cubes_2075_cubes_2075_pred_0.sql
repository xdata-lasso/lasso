-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ascending order of 'name', duplicate 'name' values (to catch DISTINCT mutants),
-- and the secondary sort on 'editor_id' when 'name' values are identical.
-- Also includes an editor not in 'journal_committee' and an editor in multiple committees to catch unintended JOINs.
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (101, '2023-01-01', 'AI', 500);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (102, '2023-02-01', 'Databases', 300);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (10, 'Charlie', 40.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (20, 'Alice', 35.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (5, 'Alice', 28.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (15, 'Bob', 50.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (10, 101, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (10, 102, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (20, 101, 'Lead');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM editor ORDER BY name, editor.editor_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM editor ORDER BY Age ASC, editor.editor_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Alice',)
('Charlie',)
('Bob',)
*/