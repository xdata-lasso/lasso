-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 1, 4), (0, 4, 0), (3, 3, 3), (4, 4, NULL), (1, 3, 0), (5, NULL, 4), (6, 2, NULL), (7, 4, NULL), (8, 0, 1), (9, 4, 3), (10, NULL, 0), (11, NULL, 0), (12, NULL, NULL), (13, 1, 4), (14, 4, 1), (15, 1, 0), (16, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT SUB.*, COUNT(SUB.WORK_PAIR) OVER (PARTITION BY SUB.WORK_PAIR) AS COUNT_PAIR FROM (SELECT *, ACTOR_ID || ',' || DIRECTOR_ID AS WORK_PAIR FROM ACTORDIRECTOR) AS SUB) SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM CTE WHERE COUNT_PAIR > 2;

/*
Prediction Result:
*/