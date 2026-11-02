-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (10, NULL, NULL, NULL);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (9, NULL, NULL, NULL);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (12, NULL, NULL);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (11, NULL, NULL);
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (12, 10, NULL);
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (11, 9, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.age AS age, RHS.editor_id AS editor_id, RHS.name AS name FROM (SELECT MIN(age) AS age FROM editor) AS LHS LEFT JOIN editor AS RHS ON (LHS.age = RHS.age)) ORDER BY name;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Name FROM editor ORDER BY Age ASC, editor.editor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/