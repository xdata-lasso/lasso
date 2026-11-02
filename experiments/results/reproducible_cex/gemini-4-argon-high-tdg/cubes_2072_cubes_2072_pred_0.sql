-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (1, '2023-01-10', 'Science', 500);
INSERT INTO journal (Journal_ID, Date, Theme, Sales) VALUES (2, '2023-06-15', 'History', 1200);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (1, 'Alice', 35.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (2, 'Mona', 62.5);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (3, 'Zack', 40.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (4, 'Zack', 40.0);
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (1, 1, 'Review');
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (3, 1, 'Edit');
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (3, 2, 'Publish');
INSERT INTO journal_committee (Editor_ID, Journal_ID, Work_Type) VALUES (4, 2, 'Review');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age FROM (SELECT * FROM (SELECT * FROM (SELECT age, name, COUNT(*) AS n FROM editor GROUP BY age, name) ORDER BY age DESC) LIMIT 1);

/*
Gold Result:
(62.5,)
*/

-- Prediction Query
SELECT Age FROM editor GROUP BY Age ORDER BY COUNT(*) DESC, Age NULLS LAST LIMIT 1;

/*
Prediction Result:
(40.0,)
*/