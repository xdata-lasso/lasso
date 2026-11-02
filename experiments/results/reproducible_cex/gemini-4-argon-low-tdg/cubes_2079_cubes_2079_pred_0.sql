-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests complex ORDER BY clauses: tie-breaking across Date, Theme, and Sales, plus NULLS LAST handling for Date, Theme, and Sales.
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2023-01-01', 'Bio', 100);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2023-01-01', 'Bio', 50);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (3, '2023-01-01', 'Bio', NULL);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (4, '2023-01-01', 'Astro', 200);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (5, '2023-01-01', NULL, 300);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (6, NULL, 'Chem', 400);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (7, '2022-12-31', 'Physics', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, theme, sales FROM (SELECT * FROM journal AS LHS WHERE NOT EXISTS(SELECT 1 FROM journal_committee AS RHS WHERE (LHS.journal_id = RHS.journal_id))) ORDER BY date, theme NULLS LAST, sales NULLS LAST;

/*
Gold Result:
(None, 'Chem', 400)
('2022-12-31', 'Physics', 10)
('2023-01-01', 'Astro', 200)
('2023-01-01', 'Bio', 50)
('2023-01-01', 'Bio', 100)
('2023-01-01', 'Bio', None)
('2023-01-01', None, 300)
*/

-- Prediction Query
SELECT date, theme, sales FROM journal EXCEPT SELECT T1.date, T1.theme, T1.sales FROM journal AS T1 JOIN journal_committee AS T2 ON T1.journal_ID = T2.journal_ID;

/*
Prediction Result:
(None, 'Chem', 400)
('2022-12-31', 'Physics', 10)
('2023-01-01', None, 300)
('2023-01-01', 'Astro', 200)
('2023-01-01', 'Bio', None)
('2023-01-01', 'Bio', 50)
('2023-01-01', 'Bio', 100)
*/