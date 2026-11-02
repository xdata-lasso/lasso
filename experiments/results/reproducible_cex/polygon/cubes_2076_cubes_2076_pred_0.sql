-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (15, '21', '21', 21);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (16, '21', '21', 21);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (14, '21', 22);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (13, '21', 23);
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (14, 16, NULL);
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (13, 15, '27');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.n AS n FROM editor AS LHS INNER JOIN (SELECT editor_id, COUNT(*) AS n FROM journal_committee GROUP BY editor_id) AS RHS ON (LHS.editor_id = RHS.editor_id)) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.Name FROM editor AS T1 JOIN journal_committee AS T2 ON T1.Editor_ID = T2.Editor_ID GROUP BY T1.Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('21',)
*/