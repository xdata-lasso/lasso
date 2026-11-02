-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, NULL, 4), (3, 2, 2), (1, 4, NULL), (4, 4, 2), (2, NULL, 3), (5, 3, NULL), (6, 4, NULL), (7, 1, 0), (8, 4, 1), (9, 0, 0), (10, 3, 0), (11, 4, 2), (12, 4, 0), (13, 1, 2), (14, NULL, 4), (15, NULL, 4), (16, 2, NULL), (17, 3, 0), (18, 4, 1), (19, 0, 4), (20, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 4)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID) AS CNT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS TEMP WHERE CNT >= 3;

/*
Prediction Result:
*/