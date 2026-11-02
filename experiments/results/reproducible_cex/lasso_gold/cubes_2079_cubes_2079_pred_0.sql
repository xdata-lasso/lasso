-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1008, 'offer', 'begin', 1009);
INSERT INTO "journal" ("journal_id", "date", "theme", "sales") VALUES (1010, 'offer', 'begin', 1009);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, theme, sales FROM (SELECT * FROM journal AS LHS WHERE NOT EXISTS(SELECT 1 FROM journal_committee AS RHS WHERE (LHS.journal_id = RHS.journal_id))) ORDER BY date, theme NULLS LAST, sales NULLS LAST;

/*
Gold Result:
('offer', 'begin', 1009)
('offer', 'begin', 1009)
*/

-- Prediction Query
SELECT date, theme, sales FROM journal EXCEPT SELECT T1.date, T1.theme, T1.sales FROM journal AS T1 JOIN journal_committee AS T2 ON T1.journal_ID = T2.journal_ID;

/*
Prediction Result:
('offer', 'begin', 1009)
*/