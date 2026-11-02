-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (7, '1', '1', 1);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (6, '1', '1', 1);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (9, '12', NULL);
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (8, NULL, NULL);
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (8, 7, '1');
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (8, 6, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM editor GROUP BY age, name) ORDER BY age, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
*/

-- Prediction Query
SELECT Age, COUNT(*) FROM editor GROUP BY Age;

/*
Prediction Result:
(None, 2)
*/