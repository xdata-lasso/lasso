-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Alice', 'Zorro', '10m', 30);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Bob', 'Aladdin', '20m', 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CHARACTER, duration FROM actor ORDER BY CHARACTER, actor.actor_id NULLS LAST;

/*
Gold Result:
('Aladdin', '20m')
('Zorro', '10m')
*/

-- Prediction Query
SELECT CHARACTER, Duration FROM actor;

/*
Prediction Result:
('Zorro', '10m')
('Aladdin', '20m')
*/