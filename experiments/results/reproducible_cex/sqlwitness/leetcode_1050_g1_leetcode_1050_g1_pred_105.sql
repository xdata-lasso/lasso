-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 4, 0), (3, NULL, NULL), (0, 2, 2), (1, 4, 3), (4, 3, 2), (5, NULL, NULL), (6, 2, 1), (7, 4, 2), (8, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS MATCH_COUNTER FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS TEMP WHERE MATCH_COUNTER >= 3;

/*
Prediction Result:
(None, None)
*/