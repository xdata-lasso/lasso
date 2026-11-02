-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic grouping by (Nominee, Year), tie-breaking in ORDER BY (same Nominee with different counts across years), and ensures unreferenced actors or actors with multiple musicals don't falsely alter the count via accidental JOINs.
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Musical A', 2000, 'Tony', 'Best Musical', 'Alice', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'Musical B', 2000, 'Drama Desk', 'Best Musical', 'Alice', 'Nominated');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (3, 'Musical C', 2001, 'Tony', 'Best Musical', 'Alice', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (4, 'Musical D', 1999, 'Tony', 'Best Director', 'Bob', 'Nominated');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'John', 'Lead', '2h', 30);
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