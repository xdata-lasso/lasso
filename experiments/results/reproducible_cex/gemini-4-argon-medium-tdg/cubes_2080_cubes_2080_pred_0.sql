-- Schema DDL
CREATE TABLE "journal" ("Journal_ID" INTEGER PRIMARY KEY, "Date" TEXT, "Theme" TEXT, "Sales" INTEGER);

CREATE TABLE "editor" ("Editor_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Age" REAL);

CREATE TABLE "journal_committee" ("Editor_ID" INTEGER, "Journal_ID" INTEGER, "Work_Type" TEXT, PRIMARY KEY ("Editor_ID", "Journal_ID"), FOREIGN KEY ("Journal_ID") REFERENCES "journal" ("Journal_ID"), FOREIGN KEY ("Editor_ID") REFERENCES "editor" ("Editor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO editor (Editor_ID, Name, Age) VALUES (1, 'Alice', 30.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (2, 'Alice', 30.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (3, 'Bob', 30.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (4, 'Charlie', 25.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (5, 'Charlie', 25.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (6, 'Charlie', 25.0);
INSERT INTO editor (Editor_ID, Name, Age) VALUES (7, 'David', 25.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM editor GROUP BY age, name) ORDER BY age, count___ NULLS LAST;

/*
Gold Result:
(25.0, 1)
(25.0, 3)
(30.0, 1)
(30.0, 2)
*/

-- Prediction Query
SELECT Age, COUNT(*) FROM editor GROUP BY Age;

/*
Prediction Result:
(25.0, 4)
(30.0, 3)
*/