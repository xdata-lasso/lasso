-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: journal --
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1, 'jou_5f3759', 'jou_c9b382', 3000);

INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (-2147483647, 'jou_f59d33', 'jou_4a5706', 3000);

-- Inserting into table: editor --
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1, 'lhs_ac2943', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (-2147483647, 'lhs_9d27ed', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (3, 'lhs_ac2943', 1.0);

INSERT INTO "editor" ("editor_id", "name", "age") VALUES (2, '5k5swwqcgs', 171.746906);

-- Inserting into table: journal_committee --
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (1, 1, 'rhs_00f095');

INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (2, 1, 'rhs_00f095');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, LHS.journal_id AS journal_id, LHS.work_type AS work_type, RHS.date AS date, RHS.theme AS theme, RHS.sales AS sales FROM (SELECT LHS.editor_id AS editor_id, LHS.name AS name, LHS.age AS age, RHS.journal_id AS journal_id, RHS.work_type AS work_type FROM editor AS LHS INNER JOIN journal_committee AS RHS ON (LHS.editor_id = RHS.editor_id)) AS LHS INNER JOIN (SELECT * FROM journal WHERE (sales >= 3000)) AS RHS ON (LHS.journal_id = RHS.journal_id)) ORDER BY name;

/*
Gold Result:
('5k5swwqcgs',)
('lhs_ac2943',)
*/

-- Prediction Query
SELECT T2.Name FROM journal_committee AS T1 JOIN editor AS T2 ON T1.Editor_ID = T2.Editor_ID JOIN journal AS T3 ON T1.Journal_ID = T3.Journal_ID WHERE T3.Sales > 3000;

/*
Prediction Result:
*/