-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1204, 'Amy Romero', 1207.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1205, 'Amy Romero', 1214.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1206, 'Amy Romero', 1221.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1216, 'Amy Romero', 1219.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1217, 'Amy Romero', 1226.5);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1218, 'Amy Romero', 1233.5);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1210, 'over', 'phone', 1213);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1211, 'employee', 'among', 1222.0);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1212, 'particular', 'president', 1231.0);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1222, 'past', 'four', 1225);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1223, 'other', 'worry', 1234.0);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1224, 'necessary', 'every', 1243.0);
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (1204, 1210, 'beat');
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (1204, 1211, 'kind');
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (1204, 1212, 'really');
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (1216, 1222, 'democratic');
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (1216, 1223, 'relationship');
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (1216, 1224, 'sense');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.n AS n FROM editor AS LHS INNER JOIN (SELECT editor_id, COUNT(*) AS n FROM journal_committee GROUP BY editor_id) AS RHS ON (LHS.editor_id = RHS.editor_id)) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Amy Romero',)
('Amy Romero',)
*/

-- Prediction Query
SELECT T1.Name FROM editor AS T1 JOIN journal_committee AS T2 ON T1.Editor_ID = T2.Editor_ID GROUP BY T1.Name HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Amy Romero',)
*/