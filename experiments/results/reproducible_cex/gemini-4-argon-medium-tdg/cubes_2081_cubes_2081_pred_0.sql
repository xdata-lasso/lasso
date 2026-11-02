-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests: ORDER BY tie-breaking across all three columns (Name, Age, Theme), ASC vs DESC, and NULLS LAST vs NULLS FIRST.
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2023-01-01', 'Zeta', 10);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2023-01-02', 'Alpha', 20);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (3, '2023-01-03', NULL, 30);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'SameName', 50.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'SameName', 20.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (3, 'SameName', NULL);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (4, NULL, 35.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 1, 'WorkA');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 1, 'WorkB');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 2, 'WorkC');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 3, 'WorkD');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (3, 2, 'WorkE');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (4, 1, 'WorkF');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age, theme FROM (SELECT LHS.journal_id AS journal_id, LHS.date AS date, LHS.theme AS theme, LHS.sales AS sales, LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.work_type AS work_type FROM (SELECT LHS.journal_id AS journal_id, LHS.date AS date, LHS.theme AS theme, LHS.sales AS sales, RHS.editor_id AS editor_id, RHS.name AS name, RHS.age AS age FROM journal AS LHS CROSS JOIN editor AS RHS) AS LHS INNER JOIN journal_committee AS RHS ON (LHS.journal_id = RHS.journal_id AND LHS.editor_id = RHS.editor_id)) ORDER BY name, age NULLS LAST, theme NULLS LAST;

/*
Gold Result:
(None, 35.0, 'Zeta')
('SameName', 20.0, 'Alpha')
('SameName', 20.0, 'Zeta')
('SameName', 20.0, None)
('SameName', 50.5, 'Zeta')
('SameName', None, 'Alpha')
*/

-- Prediction Query
SELECT T2.Name, T2.age, T3.Theme FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID = T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID = T3.Journal_ID ORDER BY T3.Theme ASC, T1.editor_id NULLS LAST, T1.journal_id NULLS LAST, T2.editor_id NULLS LAST, T3.journal_id NULLS LAST;

/*
Prediction Result:
('SameName', 20.0, None)
('SameName', 20.0, 'Alpha')
('SameName', None, 'Alpha')
('SameName', 50.5, 'Zeta')
('SameName', 20.0, 'Zeta')
(None, 35.0, 'Zeta')
*/