-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by CHARACTER vs ordering by age, duration, Name, or insertion order, and tests LIMIT 1.
-- Also includes a musical row and valid FK references to distinguish queries that incorrectly JOIN with musical.
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Les Miserables', 1987, 'Tony', 'Best Musical', 'Musical', 'Won');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Zack', 'Charlie', '5 Years', 60);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Alice', 'Beta', '1 Year', 10);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 1, 'Mona', 'Alpha', '3 Years', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT duration FROM (SELECT * FROM (SELECT * FROM (SELECT CHARACTER, duration, MAX(age) AS age FROM actor GROUP BY CHARACTER, duration) ORDER BY CHARACTER) LIMIT 1);

/*
Gold Result:
('3 Years',)
*/

-- Prediction Query
SELECT Duration FROM actor ORDER BY Age DESC, actor.actor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('5 Years',)
*/