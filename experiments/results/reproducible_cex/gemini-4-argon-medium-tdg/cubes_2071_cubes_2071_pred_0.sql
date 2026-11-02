-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (10, '2023-01-01', 'AI', 2999);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (20, '2023-02-01', 'DB', 3000);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (30, '2023-03-01', 'OS', 3001);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (40, '2023-04-01', 'SE', NULL);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Zoe', 45.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Alice', 30.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'Bob', 25.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (4, 'Charlie', 50.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 20, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 30, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 10, 'Publish');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (4, 40, 'Proof');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, LHS.journal_id AS journal_id, LHS.work_type AS work_type, RHS.date AS date, RHS.theme AS theme, RHS.sales AS sales FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.journal_id AS journal_id, RHS.work_type AS work_type FROM editor AS LHS INNER JOIN journal_committee AS RHS ON (LHS.editor_id = RHS.editor_id)) AS LHS INNER JOIN (SELECT * FROM journal WHERE (sales >= 3000)) AS RHS ON (LHS.journal_id = RHS.journal_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT T2.Name FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID = T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID = T3.Journal_ID WHERE T3.Sales > 3000;

/*
Prediction Result:
('Alice',)
*/