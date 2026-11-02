-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (1, 'Wicked', 2003, 'Tony', 'Best Musical', 'Stephen Schwartz', 'Nominated');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (2, 'Cats', 1982, 'Tony', 'Best Musical', 'Andrew Lloyd Webber', 'Won');
INSERT INTO "musical" ("Musical_ID", "Name", "Year", "Award", "Category", "Nominee", "Result") VALUES (4, 'Rent', 1996, 'Pulitzer', 'Drama', 'Jonathan Larson', 'Won');
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (1, 2, 'Zoe', 'Grizabella', '2 years', 35);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (2, 1, 'Alice', 'Elphaba', '1 year', 28);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (3, 1, 'Alice', 'Glinda', '3 years', 30);
INSERT INTO "actor" ("Actor_ID", "Musical_ID", "Name", "Character", "Duration", "age") VALUES (4, 3, 'Bob', 'Phantom', '5 years', 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.actor_id AS actor_id, LHS.name AS name, LHS.musical_id AS musical_id, LHS.character AS CHARACTER, LHS.duration AS duration, LHS.age AS age, RHS.name AS name_other, RHS.year AS YEAR, RHS.award AS award, RHS.category AS category, RHS.nominee AS nominee, RHS.result AS RESULT FROM actor AS LHS INNER JOIN musical AS RHS ON (LHS.musical_id = RHS.musical_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Alice', 'Wicked')
('Alice', 'Wicked')
('Zoe', 'Cats')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID;

/*
Prediction Result:
('Zoe', 'Cats')
('Alice', 'Wicked')
('Alice', 'Wicked')
*/