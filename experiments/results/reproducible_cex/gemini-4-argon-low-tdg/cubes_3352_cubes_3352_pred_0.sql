-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'M1', 1980, 'Tony', 'Best Actor', 'Zack', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'M2', 1990, 'Tony', 'Best Actor', 'Aaron', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (3, 'M3', 1990, 'Drama', 'Best Actor', 'Aaron', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (4, 'M4', 1990, 'Grammy', 'Best Score', 'Aaron', 'Won');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT nominee FROM (SELECT * FROM (SELECT * FROM (SELECT nominee, YEAR, MAX(n) AS n FROM (SELECT nominee, YEAR, COUNT(*) AS n FROM musical GROUP BY nominee, YEAR) GROUP BY nominee, YEAR) ORDER BY YEAR) LIMIT 1);

/*
Gold Result:
('Zack',)
*/

-- Prediction Query
SELECT Nominee FROM musical GROUP BY Nominee ORDER BY COUNT(*) DESC, Nominee NULLS LAST LIMIT 1;

/*
Prediction Result:
('Aaron',)
*/