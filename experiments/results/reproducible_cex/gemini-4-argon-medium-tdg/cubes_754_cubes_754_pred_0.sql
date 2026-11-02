-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'Les Miserables', 1987, 'Tony Award', 'Best Musical', 'Cameron Mackintosh', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'The Phantom of the Opera', 1988, 'Tony Award', 'Best Musical', 'Andrew Lloyd Webber', 'Won');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Colm Wilkinson', 'Jean Valjean', '1987-1988', 43);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Michael Ball', 'Marius', '1985-1986', 23);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 1, 'Hugh Jackman', 'Jean Valjean', '2012', 44);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (4, 2, 'Michael Crawford', 'The Phantom', '1986-1989', 44);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (5, 2, 'Sarah Brightman', 'Christine Daae', '1986-1988', 26);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CHARACTER FROM actor ORDER BY CHARACTER, actor.actor_id NULLS LAST;

/*
Gold Result:
('Christine Daae',)
('Jean Valjean',)
('Jean Valjean',)
('Marius',)
('The Phantom',)
*/

-- Prediction Query
SELECT CHARACTER FROM actor ORDER BY age DESC, actor.actor_id NULLS LAST;

/*
Prediction Result:
('Jean Valjean',)
('The Phantom',)
('Jean Valjean',)
('Christine Daae',)
('Marius',)
*/