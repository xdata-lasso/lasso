-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. Empty result set behavior (GROUP BY work_type returns 0 rows when no 'Photo' exists, whereas a query missing GROUP BY returns 1 row with NULL).
-- 2. Case sensitivity and substring matching ('photo', 'Photography', 'Edit').
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2023-05-01', 'Photo', 50);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2023-06-01', 'Tech', 75);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Dave', 50.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Eve', 35.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 1, 'photo');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 2, 'Photography');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meansales" AS "avg_t1_sales_" FROM (SELECT "work_type", AVG("sales") AS "meansales" FROM (SELECT * FROM (SELECT "LHS"."journal_id" AS "journal_id", "LHS"."date" AS "date", "LHS"."theme" AS "theme", "LHS"."sales" AS "sales", "RHS"."editor_id" AS "editor_id", "RHS"."work_type" AS "work_type" FROM "journal" AS "LHS" INNER JOIN "journal_committee" AS "RHS" ON ("LHS"."journal_id" = "RHS"."journal_id")) WHERE ("work_type" = 'Photo')) GROUP BY work_type) ORDER BY avg_t1_sales_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(T1.sales) FROM journal AS T1 JOIN journal_committee AS T2 ON T1.journal_ID = T2.journal_ID WHERE T2.work_type = 'Photo';

/*
Prediction Result:
(None,)
*/