-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (1, NULL, 10);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (2, NULL, 10);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (3, NULL, 10);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (4, 10, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (5, 10, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (6, 10, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (7, NULL, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (8, NULL, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (9, NULL, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (10, NULL, 20);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (11, NULL, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, None)
(None, 10)
(10, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID || '*' || DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 10)
*/