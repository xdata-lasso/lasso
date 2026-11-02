-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests tie-breaking on the maximum age vs missing LIMIT 1 (where multiple distinct (age, name) pairs share the highest age)
-- Also tests ordering by age vs ordering by count (n) or name, and tests unnecessary INNER JOINs with journal_committee.
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2023-01-01', 'AI', 500);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Alice', 65.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Bob', 65.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'Charlie', 40.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (4, 'Charlie', 40.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (5, 'Charlie', 40.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (6, 'Zack', 25.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 1, 'Review');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT * FROM (SELECT * FROM (SELECT age, name, COUNT(*) AS n FROM editor GROUP BY age, name) ORDER BY age DESC) LIMIT 1);

/*
Gold Result:
(65.5,)
*/

-- Prediction Query
SELECT Age FROM editor GROUP BY Age ORDER BY COUNT(*) DESC, Age NULLS LAST LIMIT 1;

/*
Prediction Result:
(40.0,)
*/