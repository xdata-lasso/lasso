-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, NULL, NULL, NULL);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2022-05-01', 'Zebra', 50);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (3, '2022-06-01', 'Alpha', 500);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Alice', NULL);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, NULL, 25.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'Bob', 60.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 1, NULL);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 2, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 3, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 1, 'Proof');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 3, 'Lead');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 1, 'Admin');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, theme FROM (SELECT LHS.journal_id AS journal_id, LHS.date AS date, LHS.theme AS theme, LHS.sales AS sales, LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.work_type AS work_type FROM (SELECT LHS.journal_id AS journal_id, LHS.date AS date, LHS.theme AS theme, LHS.sales AS sales, RHS.editor_id AS editor_id, RHS.name AS name, RHS.age AS age FROM journal AS LHS CROSS JOIN editor AS RHS) AS LHS INNER JOIN journal_committee AS RHS ON (LHS.journal_id = RHS.journal_id AND LHS.editor_id = RHS.editor_id)) ORDER BY name, theme NULLS LAST;

/*
Gold Result:
(None, 'Alpha')
(None, None)
('Alice', 'Alpha')
('Alice', 'Zebra')
('Alice', None)
('Bob', None)
*/

-- Prediction Query
SELECT T2.Name, T3.Theme FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID = T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID = T3.Journal_ID;

/*
Prediction Result:
('Alice', None)
('Alice', 'Zebra')
('Alice', 'Alpha')
(None, None)
(None, 'Alpha')
('Bob', None)
*/