-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Bob', 'Char1', '1yr', 25);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Alice', 'Char2', '2yr', 30);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor WHERE (age <> 20) ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT Name FROM actor WHERE Age <> 20;

/*
Prediction Result:
('Bob',)
('Alice',)
*/