-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (actor_id, musical_id, name, character, duration, age) VALUES (0, NULL, NULL, 'default2', 'default2', NULL), (1, NULL, 'default1', 'default1', 'default1', 0), (2, NULL, 'default1', 'default1', NULL, NULL), (3, NULL, 'default1', NULL, NULL, NULL);
UPDATE actor SET musical_id = CASE actor_id WHEN 0 THEN 0 WHEN 1 THEN 3 WHEN 2 THEN 3 WHEN 3 THEN 1 END WHERE actor_id IN (0, 1, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CHARACTER, duration FROM actor ORDER BY CHARACTER, actor.actor_id NULLS LAST;

/*
Gold Result:
(None, None)
('default1', 'default1')
('default1', None)
('default2', 'default2')
*/

-- Prediction Query
SELECT CHARACTER, Duration FROM actor;

/*
Prediction Result:
('default2', 'default2')
('default1', 'default1')
('default1', None)
(None, None)
*/