-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Hamilton', 2015, 'Tony', 'Best Musical', 'Lin-Manuel Miranda', 'Won');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Alice', 'Role1', '2 years', 19);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Bob', 'Role2', '1 year', 20);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 1, 'Charlie', 'Role3', '3 years', 21);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (4, 1, 'Alice', 'Role4', '4 years', 25);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (5, 1, 'David', 'Role5', '1 year', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor WHERE (age <> 20) ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM actor WHERE Age <> 20;

/*
Prediction Result:
('Alice',)
('Charlie',)
('Alice',)
*/