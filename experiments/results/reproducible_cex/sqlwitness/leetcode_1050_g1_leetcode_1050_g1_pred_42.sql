-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 4, 3), (3, 3, 1), (0, 1, 2), (2, 1, 3), (4, 2, 2), (5, NULL, 0), (6, 2, 4), (7, 1, NULL), (8, 1, 2), (9, 1, 4), (10, 2, 0), (11, 4, 2), (12, 0, 2), (13, 2, 3), (14, 4, 4), (15, NULL, 0), (16, 3, 0), (17, 0, 4), (18, 1, 1), (19, 0, 3), (20, NULL, 0), (21, NULL, 1), (22, 0, 4), (23, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS CNT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING CNT >= 3) AS T;

/*
Prediction Result:
(None, 0)
*/