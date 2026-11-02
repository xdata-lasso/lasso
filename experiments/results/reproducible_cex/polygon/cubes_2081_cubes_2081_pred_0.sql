-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (19, '25', '26', 27);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (20, NULL, NULL, NULL);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (28, NULL, 30);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (34, NULL, 30);
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (28, 20, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, age, theme FROM (SELECT LHS.journal_id AS journal_id, LHS.date AS date, LHS.theme AS theme, LHS.sales AS sales, LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.work_type AS work_type FROM (SELECT LHS.journal_id AS journal_id, LHS.date AS date, LHS.theme AS theme, LHS.sales AS sales, RHS.editor_id AS editor_id, RHS.name AS name, RHS.age AS age FROM journal AS LHS CROSS JOIN editor AS RHS) AS LHS INNER JOIN journal_committee AS RHS ON (LHS.journal_id = RHS.journal_id AND LHS.editor_id = RHS.editor_id)) ORDER BY name, age NULLS LAST, theme NULLS LAST;

/*
Gold Result:
(None, 30.0, None)
*/

-- Prediction Query
SELECT T2.Name, T2.age, T3.Theme FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID = T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID = T3.Journal_ID ORDER BY T3.Theme ASC, T1.editor_id NULLS LAST, T1.journal_id NULLS LAST, T2.editor_id NULLS LAST, T3.journal_id NULLS LAST;

/*
Prediction Result:
(None, 30.0, None)
*/