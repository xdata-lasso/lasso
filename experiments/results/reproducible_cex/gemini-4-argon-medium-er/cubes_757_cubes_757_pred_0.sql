-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Alice', 'B', '2 years', 30);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Bob', 'A', '1 year', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CHARACTER, duration FROM actor ORDER BY CHARACTER, actor.actor_id NULLS LAST;

/*
Gold Result:
('A', '1 year')
('B', '2 years')
*/

-- Prediction Query
SELECT CHARACTER, Duration FROM actor;

/*
Prediction Result:
('B', '2 years')
('A', '1 year')
*/