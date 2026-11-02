-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 0, 2), (2, 3, NULL), (1, NULL, 1), (0, 1, 2), (4, 3, 0), (5, 3, 3), (6, 3, 1), (7, 1, NULL), (8, 2, 3), (9, 1, 1), (10, 0, 1), (11, 1, 0), (12, NULL, 1), (13, 0, NULL), (14, NULL, NULL), (15, 1, 0), (16, 1, 1), (17, 1, NULL), (18, 3, 0), (19, 3, 1), (20, 1, 0), (21, 1, 1), (22, 2, NULL), (23, 1, 1), (24, 2, 0), (25, 0, 2), (26, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, 0)
(1, 1)
*/

-- Prediction Query
WITH ACTOR_DIRECTOR_PAIRS AS (SELECT ACTOR_ID AS ACTOR_ID, DIRECTOR_ID AS DIRECTOR_ID, COUNT(*) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS PAIR_COUNT FROM ACTORDIRECTOR) SELECT DISTINCT ACTOR_ID AS ACTOR_ID, DIRECTOR_ID AS DIRECTOR_ID FROM ACTOR_DIRECTOR_PAIRS WHERE PAIR_COUNT > 2;

/*
Prediction Result:
(None, 1)
(1, 0)
(1, 1)
*/