-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1050, 1051, 'Melanie Herrera', 'example', 'specific', 1052);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1054, 1055, 'Kimberly Osborne', 'movement', 'while', 1053);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1051, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "actor" ("actor_id", "musical_id", "name", "character", "duration", "age") VALUES (1055, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1051, 'April Nguyen', 1053, 'long', 'about', 'seven', 'type');
INSERT INTO "musical" ("musical_id", "name", "year", "award", "category", "nominee", "result") VALUES (1055, 'Ashley Graham', 1057, 'politics', 'decide', 'claim', 'hour');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.actor_id AS actor_id, LHS.name AS name, LHS.musical_id AS musical_id, LHS.character AS CHARACTER, LHS.duration AS duration, LHS.age AS age, RHS.name AS name_other, RHS.year AS YEAR, RHS.award AS award, RHS.category AS category, RHS.nominee AS nominee, RHS.result AS RESULT FROM actor AS LHS INNER JOIN musical AS RHS ON (LHS.musical_id = RHS.musical_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Kimberly Osborne', 'Ashley Graham')
('Melanie Herrera', 'April Nguyen')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID;

/*
Prediction Result:
('Melanie Herrera', 'April Nguyen')
('Kimberly Osborne', 'Ashley Graham')
*/