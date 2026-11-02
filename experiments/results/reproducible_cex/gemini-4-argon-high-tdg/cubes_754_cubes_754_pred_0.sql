-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (1, 'The Phantom of the Opera', 1986, 'Tony Award', 'Best Musical', 'Andrew Lloyd Webber', 'Won');
INSERT INTO musical (Musical_ID, Name, Year, Award, Category, Nominee, Result) VALUES (2, 'Les Miserables', 1987, 'Tony Award', 'Best Book', 'Alain Boublil', 'Nominated');
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (1, 1, 'Michael Crawford', 'Zorro', '3 years', 45);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (2, 1, 'Sarah Brightman', 'Christine Daae', '2 years', 28);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (3, 2, 'Colm Wilkinson', 'Jean Valjean', '1 year', 42);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (4, NULL, 'Aaron Tveit', 'Christine Daae', '5 years', 21);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (5, 3, 'Bebe Neuwirth', NULL, '4 years', 35);
INSERT INTO actor (Actor_ID, Musical_ID, Name, Character, Duration, age) VALUES (6, 4, 'Alice Ripley', 'Aladdin', '6 months', 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CHARACTER FROM actor ORDER BY CHARACTER, actor.actor_id NULLS LAST;

/*
Gold Result:
(None,)
('Aladdin',)
('Christine Daae',)
('Christine Daae',)
('Jean Valjean',)
('Zorro',)
*/

-- Prediction Query
SELECT CHARACTER FROM actor ORDER BY age DESC, actor.actor_id NULLS LAST;

/*
Prediction Result:
('Aladdin',)
('Zorro',)
('Jean Valjean',)
(None,)
('Christine Daae',)
('Christine Daae',)
*/