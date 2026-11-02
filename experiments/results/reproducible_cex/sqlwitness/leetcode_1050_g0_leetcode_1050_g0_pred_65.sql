-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 4, 4), (4, NULL, 2), (1, 2, 1), (0, 2, 0), (3, 2, 2), (5, 1, 3), (6, 4, 2), (7, 2, 3), (8, NULL, 1), (9, NULL, 1), (10, NULL, 2), (11, NULL, 1), (12, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID) AS NUM FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS X WHERE NUM >= 3;

/*
Prediction Result:
*/