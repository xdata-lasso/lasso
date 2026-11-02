-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'The Phantom of the Opera', 1986, 'Tony Award', 'Best Musical', 'Andrew Lloyd Webber', 'Won');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Zack', 'Phantom', '9 years', 50);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Alice', 'Zorro', '1 year', 30);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 2, 'Bob', 'Phantom', '1 year', 20);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (4, NULL, 'Charlie', 'Annie', '2 years', 12);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (5, 4, 'Diana', 'Annie', '2 years', 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CHARACTER, duration FROM actor ORDER BY CHARACTER, actor.actor_id NULLS LAST;

/*
Gold Result:
('Annie', '2 years')
('Annie', '2 years')
('Phantom', '9 years')
('Phantom', '1 year')
('Zorro', '1 year')
*/

-- Prediction Query
SELECT CHARACTER, Duration FROM actor;

/*
Prediction Result:
('Phantom', '9 years')
('Zorro', '1 year')
('Phantom', '1 year')
('Annie', '2 years')
('Annie', '2 years')
*/