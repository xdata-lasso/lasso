-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 1, 3), (3, 3, 3), (1, 1, 4), (4, 1, 0), (0, 4, 4), (5, 1, 3), (6, 4, 3), (7, NULL, 2), (8, NULL, 2), (9, NULL, 2), (10, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 2)
*/

-- Prediction Query
WITH CTE AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY ACTOR_ID, DIRECTOR_ID) AS CNT FROM ACTORDIRECTOR) SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM CTE WHERE CNT >= 3;

/*
Prediction Result:
*/