-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (1, '2023-05-01', 'Zebra', 100);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (2, '2023-01-01', 'Apple', 500);
INSERT INTO "journal" ("Journal_ID", "Date", "Theme", "Sales") VALUES (3, '2023-03-01', 'Mango', 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM journal ORDER BY theme, journal.journal_id NULLS LAST;

/*
Gold Result:
('Apple',)
('Mango',)
('Zebra',)
*/

-- Prediction Query
SELECT DISTINCT Theme FROM journal;

/*
Prediction Result:
('Zebra',)
('Apple',)
('Mango',)
*/