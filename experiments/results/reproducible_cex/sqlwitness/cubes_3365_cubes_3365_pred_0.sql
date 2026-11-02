-- Schema DDL
CREATE TABLE "musical" ("Musical_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Year" INTEGER, "Award" TEXT, "Category" TEXT, "Nominee" TEXT, "Result" TEXT);

CREATE TABLE "actor" ("Actor_ID" INTEGER PRIMARY KEY, "Musical_ID" INTEGER, "Name" TEXT, "Character" TEXT, "Duration" TEXT, "age" INTEGER, FOREIGN KEY ("Musical_ID") REFERENCES "actor" ("Actor_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actor (actor_id, musical_id, name, character, duration, age) VALUES (1, NULL, 'default1', NULL, 'default1', 0), (2, NULL, 'default1', NULL, 'default1', 2), (0, NULL, 'default2', NULL, 'default1', NULL), (3, NULL, 'default1', NULL, NULL, 0), (4, NULL, NULL, 'default1', 'default2', 1), (5, NULL, NULL, NULL, NULL, 0);
UPDATE actor SET musical_id = CASE actor_id WHEN 1 THEN 4 WHEN 2 THEN 4 WHEN 0 THEN 2 WHEN 3 THEN 5 WHEN 4 THEN 3 WHEN 5 THEN 0 END WHERE actor_id IN (1, 2, 0, 3, 4, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT duration FROM (SELECT * FROM (SELECT * FROM (SELECT CHARACTER, duration, MAX(age) AS age FROM actor GROUP BY CHARACTER, duration) ORDER BY CHARACTER) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Duration FROM actor ORDER BY Age DESC, actor.actor_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/