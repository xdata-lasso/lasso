-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'M1', 2000, 'A1', 'C1', 'N1', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'M2', 2001, 'A2', 'C2', 'N2', 'Lost');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Zoe', 'Char1', '2000', 30);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 2, 'Alice', 'Char2', '2001', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.actor_id AS actor_id, LHS.name AS name, LHS.musical_id AS musical_id, LHS.character AS CHARACTER, LHS.duration AS duration, LHS.age AS age, RHS.name AS name_other, RHS.year AS YEAR, RHS.award AS award, RHS.category AS category, RHS.nominee AS nominee, RHS.result AS RESULT FROM actor AS LHS INNER JOIN musical AS RHS ON (LHS.musical_id = RHS.musical_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Alice', 'M2')
('Zoe', 'M1')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID;

/*
Prediction Result:
('Zoe', 'M1')
('Alice', 'M2')
*/