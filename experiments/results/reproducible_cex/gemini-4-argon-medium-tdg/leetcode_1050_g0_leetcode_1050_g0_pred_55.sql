-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for HAVING COUNT(*) >= 3 (counts of 2, 3, and 4).
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (1, 10, 100);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (2, 10, 100);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (3, 20, 200);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (4, 20, 200);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (5, 20, 200);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (6, 30, 300);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (7, 30, 300);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (8, 30, 300);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (9, 30, 300);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(20, 200)
(30, 300)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) >= '3';

/*
Prediction Result:
*/