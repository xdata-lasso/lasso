-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'M1', 1990, 'A1', 'C1', 'N1', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'M2', 2000, 'A2', 'C2', 'N2', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'M3', 2001, 'A3', 'C3', 'N3', 'Nominated');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT RESULT FROM (SELECT * FROM (SELECT * FROM (SELECT RESULT, YEAR, MAX(n) AS n FROM (SELECT RESULT, YEAR, COUNT(*) AS n FROM musical GROUP BY RESULT, YEAR) GROUP BY RESULT, YEAR) ORDER BY YEAR) LIMIT 1);

/*
Gold Result:
('Won',)
*/

-- Prediction Query
SELECT RESULT FROM musical GROUP BY RESULT ORDER BY COUNT(*) DESC, RESULT NULLS LAST LIMIT 1;

/*
Prediction Result:
('Nominated',)
*/