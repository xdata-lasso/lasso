-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (101, '2023-01-15', 'AI Research', 500);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (102, '2023-06-20', 'Databases', 750);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Alice', 30.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Alice', 30.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'Bob', 30.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (4, 'Charlie', 30.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (5, 'Alice', 25.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 101, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 101, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 102, 'Proofread');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM editor GROUP BY age, name) ORDER BY age, count___ NULLS LAST;

/*
Gold Result:
(25.0, 1)
(30.0, 1)
(30.0, 1)
(30.0, 2)
*/

-- Prediction Query
SELECT Age, COUNT(*) FROM editor GROUP BY Age;

/*
Prediction Result:
(25.0, 1)
(30.0, 4)
*/