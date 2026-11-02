-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (actor_id, musical_id, name, character, duration, age) VALUES (1, NULL, 'default2', 'default1', 'default2', NULL), (0, NULL, NULL, NULL, NULL, NULL), (2, NULL, 'default2', NULL, 'default2', 1), (3, NULL, NULL, 'default2', 'default2', NULL), (4, NULL, 'default1', NULL, 'default1', 1);
UPDATE actor SET musical_id = CASE actor_id WHEN 1 THEN 1 WHEN 0 THEN 1 WHEN 2 THEN 3 WHEN 3 THEN 0 END WHERE actor_id IN (1, 0, 2, 3);
INSERT INTO musical (musical_id, name, year, award, category, nominee, result) VALUES (0, 'default2', NULL, NULL, 'default2', 'default1', 'default1'), (1, 'default1', 1, 'default1', 'default1', 'default1', 'default2'), (2, 'default1', NULL, NULL, NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.actor_id AS actor_id, LHS.name AS name, LHS.musical_id AS musical_id, LHS.character AS CHARACTER, LHS.duration AS duration, LHS.age AS age, RHS.name AS name_other, RHS.year AS YEAR, RHS.award AS award, RHS.category AS category, RHS.nominee AS nominee, RHS.result AS RESULT FROM actor AS LHS INNER JOIN musical AS RHS ON (LHS.musical_id = RHS.musical_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, 'default2')
('default2', 'default1')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM actor AS T1 JOIN musical AS T2 ON T1.Musical_ID = T2.Musical_ID;

/*
Prediction Result:
(None, 'default1')
('default2', 'default1')
(None, 'default2')
*/