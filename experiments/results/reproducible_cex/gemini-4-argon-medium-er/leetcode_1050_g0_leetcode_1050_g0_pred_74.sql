-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ActorDirector ("timestamp", "actor_id", "director_id") VALUES (1, 1, NULL);
INSERT INTO ActorDirector ("timestamp", "actor_id", "director_id") VALUES (2, 1, NULL);
INSERT INTO ActorDirector ("timestamp", "actor_id", "director_id") VALUES (3, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT D1.ACTOR_ID, D1.DIRECTOR_ID FROM ACTORDIRECTOR AS D1 GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/