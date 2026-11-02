-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, NULL, 1), (1, 4, 3), (3, 4, 4), (2, NULL, 0), (4, 1, 2), (5, 2, 0), (6, 1, 2), (7, 1, NULL), (8, 4, 2), (9, NULL, 3), (10, NULL, 1), (11, NULL, 1), (12, 3, 4), (13, 1, 0), (14, 4, 1), (15, 0, 2), (16, 0, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT ACTOR_ID, DIRECTOR_ID, ACTOR_ID + ',' + DIRECTOR_ID AS PAIR FROM ACTORDIRECTOR) SELECT ACTOR_ID, DIRECTOR_ID FROM T1 GROUP BY PAIR, ACTOR_ID, DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 1)
*/