-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'M1', 1980, 'Tony', 'Best', 'N1', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'M2', 1990, 'Tony', 'Best', 'N2', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (3, 'M3', 1990, 'Tony', 'Best', 'N3', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (4, 'M4', 1990, 'Tony', 'Best', 'N4', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (5, 'M5', 2000, 'Tony', 'Best', 'N5', 'Lost');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (6, 'M6', 2000, 'Tony', 'Best', 'N6', 'Lost');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'A1', 'C1', '2h', 30);
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