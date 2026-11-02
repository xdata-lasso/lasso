-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (1, NULL, 1);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (2, NULL, 1);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (3, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) > 2 ORDER BY COUNT(TIMESTAMP) DESC, ACTOR_ID NULLS LAST, DIRECTOR_ID NULLS LAST;

/*
Prediction Result:
(None, 1)
*/