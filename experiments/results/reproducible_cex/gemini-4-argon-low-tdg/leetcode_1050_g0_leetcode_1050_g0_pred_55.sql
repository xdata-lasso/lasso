-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (1, 10, 20);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (2, 10, 20);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (3, 10, 20);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (4, 10, 21);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (5, 10, 21);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (6, 11, 22);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (7, 12, 23);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (8, 12, 23);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (9, 12, 23);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (10, 12, 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(10, 20)
(12, 23)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) >= '3';

/*
Prediction Result:
*/