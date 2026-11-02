-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (actor_id, musical_id, name, character, duration, age) VALUES (0, NULL, 'default1', NULL, 'default1', 0), (19, NULL, NULL, 'default1', 'default2', 21), (21, NULL, NULL, 'default2', NULL, 21), (1, NULL, NULL, NULL, 'default1', 20), (20, NULL, 'default2', 'default1', 'default1', 0), (2, NULL, 'default2', NULL, 'default2', 20), (3, NULL, 'default2', NULL, 'default1', 0);
UPDATE actor SET musical_id = CASE actor_id WHEN 0 THEN 19 WHEN 21 THEN 19 WHEN 1 THEN 0 WHEN 20 THEN 2 WHEN 2 THEN 0 WHEN 3 THEN 21 END WHERE actor_id IN (0, 21, 1, 20, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM actor WHERE (age <> 20) ORDER BY name, actor.actor_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM actor WHERE Age <> 20;

/*
Prediction Result:
('default1',)
('default2',)
(None,)
('default2',)
(None,)
*/