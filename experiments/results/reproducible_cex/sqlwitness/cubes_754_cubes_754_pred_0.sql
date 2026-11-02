-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (actor_id, musical_id, name, character, duration, age) VALUES (1, NULL, 'default1', 'default2', 'default2', 1), (0, NULL, NULL, NULL, 'default1', NULL), (2, NULL, 'default2', 'default1', 'default1', NULL), (3, NULL, 'default2', 'default2', 'default1', 1);
UPDATE actor SET musical_id = CASE actor_id WHEN 1 THEN 2 WHEN 0 THEN 3 WHEN 2 THEN 2 END WHERE actor_id IN (1, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CHARACTER FROM actor ORDER BY CHARACTER, actor.actor_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT CHARACTER FROM actor ORDER BY age DESC, actor.actor_id NULLS LAST;

/*
Prediction Result:
('default2',)
('default2',)
(None,)
('default1',)
*/