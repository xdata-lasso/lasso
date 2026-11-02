-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (1, '2023-05-01', 'Zoology', 500);
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (2, '2021-01-15', 'Astronomy', 1200);
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (3, '2022-08-20', 'Mathematics', 300);
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (4, '2020-11-10', 'Astronomy', 800);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (10, 'Alice Smith', 42.5);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (20, 'Bob Jones', 35.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (30, 'Carol White', 50.0);
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (10, 1, 'Review');
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (20, 1, 'Edit');
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (30, 2, 'Publish');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT theme FROM journal ORDER BY theme, journal.journal_id NULLS LAST;

/*
Gold Result:
('Astronomy',)
('Astronomy',)
('Mathematics',)
('Zoology',)
*/

-- Prediction Query
SELECT DISTINCT Theme FROM journal;

/*
Prediction Result:
('Zoology',)
('Astronomy',)
('Mathematics',)
*/