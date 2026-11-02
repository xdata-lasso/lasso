-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY on (Nominee, Year) vs GROUP BY on Nominee only, and tests secondary ORDER BY on count___ (ASC vs DESC)
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'M1', 2000, 'A1', 'C1', 'Alice', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'M2', 2000, 'A2', 'C2', 'Alice', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'M3', 2001, 'A3', 'C3', 'Alice', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (4, 'M4', 2000, 'A1', 'C1', 'Bob', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nominee, n AS count___ FROM (SELECT nominee, YEAR, COUNT(*) AS n FROM musical GROUP BY nominee, YEAR) ORDER BY nominee, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 2)
('Bob', 1)
*/

-- Prediction Query
SELECT Nominee, COUNT(*) FROM musical GROUP BY Nominee;

/*
Prediction Result:
('Alice', 3)
('Bob', 1)
*/