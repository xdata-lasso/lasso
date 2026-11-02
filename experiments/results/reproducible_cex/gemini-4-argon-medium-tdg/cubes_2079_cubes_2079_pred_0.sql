-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2023-01-01', 'AI', 100);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2023-01-01', 'AI', 50);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (3, '2023-01-01', 'AI', 50);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (4, '2023-01-01', 'DB', 200);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (5, '2022-01-01', 'OS', 300);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (6, '2023-05-01', 'SE', 400);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (7, '2023-06-01', 'ML', 500);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (1, 'Alice', 35.0);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (2, 'Bob', 42.5);
INSERT INTO "editor" ("Editor_ID", "Name", "Age") VALUES (6, 'Charlie', 50.0);
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (6, 6, 'Review');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (1, 7, 'Edit');
INSERT INTO "journal_committee" ("Editor_ID", "Journal_ID", "Work_Type") VALUES (2, 7, 'Review');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, theme, sales FROM (SELECT * FROM journal AS LHS WHERE NOT EXISTS(SELECT 1 FROM journal_committee AS RHS WHERE (LHS.journal_id = RHS.journal_id))) ORDER BY date, theme NULLS LAST, sales NULLS LAST;

/*
Gold Result:
('2022-01-01', 'OS', 300)
('2023-01-01', 'AI', 50)
('2023-01-01', 'AI', 50)
('2023-01-01', 'AI', 100)
('2023-01-01', 'DB', 200)
*/

-- Prediction Query
SELECT date, theme, sales FROM journal EXCEPT SELECT T1.date, T1.theme, T1.sales FROM journal AS T1 JOIN journal_committee AS T2 ON T1.journal_ID = T2.journal_ID;

/*
Prediction Result:
('2022-01-01', 'OS', 300)
('2023-01-01', 'AI', 50)
('2023-01-01', 'AI', 100)
('2023-01-01', 'DB', 200)
*/