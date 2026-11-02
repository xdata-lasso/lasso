-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 0, 1), (3, NULL, 0), (2, 3, 3), (0, 0, 0), (4, 3, 1), (5, 1, 0), (6, 3, 3), (7, 0, 0), (8, NULL, 4), (9, 3, 3), (10, 3, 2), (11, 4, 4), (12, 4, NULL), (13, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(3, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, ACTOR_ID || '-' || DIRECTOR_ID AS PAIR, COUNT(*) AS CNT FROM ACTORDIRECTOR GROUP BY PAIR HAVING CNT >= 3) AS T;

/*
Prediction Result:
(None, 0)
(3, 3)
*/