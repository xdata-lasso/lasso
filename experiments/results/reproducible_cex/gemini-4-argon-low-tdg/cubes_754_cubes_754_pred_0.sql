-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'The Phantom of the Opera', 1986, 'Tony Award', 'Best Musical', 'Andrew Lloyd Webber', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'Les Miserables', 1987, 'Tony Award', 'Best Direction', 'Trevor Nunn', 'Nominated');
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (1, 1, 'Michael Crawford', 'The Phantom', '1986-1989', 44);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (2, 1, 'Sarah Brightman', 'Christine Daae', '1986-1988', 26);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (3, 2, 'Colm Wilkinson', 'Jean Valjean', '1985-1987', 41);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (4, 1, 'Ramin Karimloo', 'The Phantom', '2007-2009', 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CHARACTER FROM actor ORDER BY CHARACTER, actor.actor_id NULLS LAST;

/*
Gold Result:
('Christine Daae',)
('Jean Valjean',)
('The Phantom',)
('The Phantom',)
*/

-- Prediction Query
SELECT CHARACTER FROM actor ORDER BY age DESC, actor.actor_id NULLS LAST;

/*
Prediction Result:
('The Phantom',)
('Jean Valjean',)
('The Phantom',)
('Christine Daae',)
*/