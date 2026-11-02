-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Ties for minimum age (with duplicate names to test DISTINCT vs ALL, and out-of-order names to test ORDER BY name), plus a higher age, and multiple journal_committee links to kill unnecessary joins.
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2020-01-01', 'Science', 100);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2020-02-01', 'Arts', 200);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Zack', 21.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Alice', 21.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'Alice', 21.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (4, 'Bob', 45.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (5, 'Charlie', NULL);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 1, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 2, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (4, 1, 'Lead');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.age AS age, RHS.editor_id AS editor_id, RHS.name AS name FROM (SELECT MIN(age) AS age FROM editor) AS LHS LEFT JOIN editor AS RHS ON (LHS.age = RHS.age)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM editor ORDER BY Age ASC, editor.editor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Charlie',)
*/