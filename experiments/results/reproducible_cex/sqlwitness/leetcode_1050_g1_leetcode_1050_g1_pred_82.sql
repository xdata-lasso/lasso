-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, NULL, 4), (1, 2, 1), (2, 2, 4), (3, NULL, 2), (0, NULL, 0), (5, NULL, 4), (6, 2, NULL), (7, 2, NULL), (8, 1, 2), (9, 3, NULL), (10, NULL, 3), (11, NULL, 4), (12, 3, 1), (13, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM (SELECT *, COUNT(TIMESTAMP) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS CNT FROM ACTORDIRECTOR) AS A WHERE CNT >= 3;

/*
Prediction Result:
(None, 4)
*/