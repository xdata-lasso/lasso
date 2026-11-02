-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Phantom', 1986, 'Tony', 'Best Musical', 'Phantom', 'Won');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Zack', 'Lead', '2 years', 21);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Charlie', 'Villain', '1 year', 20);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 1, 'Alice', 'Heroine', '3 years', 19);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (4, 1, 'Bob', 'Sidekick', '6 months', 0);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (5, 1, 'David', 'Extra', '1 month', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor WHERE (age <> 20) ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM actor WHERE Age <> 20;

/*
Prediction Result:
('Zack',)
('Alice',)
('Bob',)
*/