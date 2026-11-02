-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 2, NULL), (3, 3, 2), (1, NULL, 1), (0, 0, 2), (4, NULL, 1), (5, 2, 1), (6, 0, 2), (7, 3, 3), (8, 1, 2), (9, 0, 0), (10, 3, 1), (11, 3, 0), (12, 3, 2), (13, 3, NULL), (14, 0, 3), (15, 3, 0), (16, 2, NULL), (17, 3, 0), (18, NULL, 1), (19, 0, 3), (20, NULL, 2), (21, 2, 1), (22, 1, 3), (23, 0, 3), (24, 3, 1), (25, 2, NULL), (26, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
(3, 0)
(0, 3)
*/

-- Prediction Query
WITH CTE AS (SELECT SUB.*, COUNT(SUB.WORK_PAIR) OVER (PARTITION BY SUB.WORK_PAIR) AS COUNT_PAIR FROM (SELECT *, ACTOR_ID || ',' || DIRECTOR_ID AS WORK_PAIR FROM ACTORDIRECTOR) AS SUB) SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM CTE WHERE COUNT_PAIR > 2;

/*
Prediction Result:
(0, 3)
(3, 0)
*/