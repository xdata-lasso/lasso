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
WITH ACTOR_DIRECTOR_PAIRS AS (SELECT ACTOR_ID AS ACTOR_ID, DIRECTOR_ID AS DIRECTOR_ID, COUNT(*) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS PAIR_COUNT FROM ACTORDIRECTOR) SELECT DISTINCT ACTOR_ID AS ACTOR_ID, DIRECTOR_ID AS DIRECTOR_ID FROM ACTOR_DIRECTOR_PAIRS WHERE PAIR_COUNT > 2;

/*
Prediction Result:
(None, 1)
*/