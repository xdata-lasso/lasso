-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "editor" ("editor_id", "name", "age") VALUES (1036, 'Andrew Stevens', 1037.5);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1038, 'capital', 'win', 1039);
INSERT INTO "journal_committee" ("editor_id", "journal_id", "work_type") VALUES (1036, 1038, 'Photo_z');
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