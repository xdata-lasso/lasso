-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by Name, duplicate Names (to kill DISTINCT mutants), and tie-breaking by Actor_ID.
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'M_Phantom', 1986, 'Tony', 'Best Musical', 'Webber', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'M_Wicked', 2003, 'Tony', 'Best Musical', 'Schwartz', 'Nominated');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Zoe', 'Christine', '2 years', 30);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Alice', 'Elphaba', '1 year', 25);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 2, 'Alice', 'Glinda', '3 years', 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT T1.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID ORDER BY T2.Year DESC, T1.actor_id NULLS LAST, T2.musical_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Zoe',)
('Alice',)
*/