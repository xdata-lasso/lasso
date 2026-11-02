-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (1, '2023-01-01', 'Unlinked Same ID', 500);
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (10, '2023-02-15', 'Robotics', 1200);
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (20, '2023-03-20', 'Astrophysics', 850);
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (30, '2023-04-10', 'Orphan Journal', 300);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (1, 'Zoe', 41.5);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (2, 'Liam', 34.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (3, 'Orphan Editor', 29.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (10, 'Unlinked ID 10', 50.0);
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (1, 20, 'Lead');
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (2, 10, 'Review');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, theme FROM (SELECT LHS.journal_id AS journal_id, LHS.date AS date, LHS.theme AS theme, LHS.sales AS sales, LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.work_type AS work_type FROM (SELECT LHS.journal_id AS journal_id, LHS.date AS date, LHS.theme AS theme, LHS.sales AS sales, RHS.editor_id AS editor_id, RHS.name AS name, RHS.age AS age FROM journal AS LHS CROSS JOIN editor AS RHS) AS LHS INNER JOIN journal_committee AS RHS ON (LHS.journal_id = RHS.journal_id AND LHS.editor_id = RHS.editor_id)) ORDER BY name, theme NULLS LAST;

/*
Gold Result:
('Liam', 'Robotics')
('Zoe', 'Astrophysics')
*/

-- Prediction Query
SELECT T2.Name, T3.Theme FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID = T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID = T3.Journal_ID;

/*
Prediction Result:
('Zoe', 'Astrophysics')
('Liam', 'Robotics')
*/