-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2023-01-01', 'Science', 2999);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2023-01-02', 'Art', 3000);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (3, '2023-01-03', 'Math', 3001);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (4, '2023-01-04', 'History', NULL);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (5, '2023-01-05', 'Physics', -5000);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Charlie', 35.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Alice', 40.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'Bob', 28.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (4, 'David', 50.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (5, 'Eve', 30.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 1, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 2, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 3, 'Proofread');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (4, 4, 'Lead');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (5, 5, 'Assist');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, LHS.journal_id AS journal_id, LHS.work_type AS work_type, RHS.date AS date, RHS.theme AS theme, RHS.sales AS sales FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.journal_id AS journal_id, RHS.work_type AS work_type FROM editor AS LHS INNER JOIN journal_committee AS RHS ON (LHS.editor_id = RHS.editor_id)) AS LHS INNER JOIN (SELECT * FROM journal WHERE (sales >= 3000)) AS RHS ON (LHS.journal_id = RHS.journal_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT T2.Name FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID = T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID = T3.Journal_ID WHERE T3.Sales > 3000;

/*
Prediction Result:
('Bob',)
*/