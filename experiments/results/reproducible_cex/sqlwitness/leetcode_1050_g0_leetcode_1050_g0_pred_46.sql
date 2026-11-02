-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 2, 3), (4, 4, 0), (1, 2, 1), (3, NULL, NULL), (2, 3, 1), (5, 2, 1), (6, 3, 0), (7, NULL, NULL), (8, 0, 1), (9, NULL, 1), (10, NULL, NULL), (11, 4, 1), (12, 1, NULL), (13, NULL, 0), (14, 3, 2), (15, NULL, 4), (16, 0, 0), (17, 3, 0), (18, 4, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY ACTOR_ID, DIRECTOR_ID) AS CNT FROM ACTORDIRECTOR) AS A WHERE CNT >= 3;

/*
Prediction Result:
*/