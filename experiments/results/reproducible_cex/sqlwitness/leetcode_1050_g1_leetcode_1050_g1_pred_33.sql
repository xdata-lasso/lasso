-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 2, 3), (2, 1, 2), (1, 4, 3), (4, 2, 3), (3, 2, 1), (5, 3, 0), (6, NULL, NULL), (7, NULL, 4), (8, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, ACTOR_ID || '-' || DIRECTOR_ID AS PAIR, COUNT(*) AS CNT FROM ACTORDIRECTOR GROUP BY PAIR HAVING CNT >= 3) AS T;

/*
Prediction Result:
(None, None)
*/