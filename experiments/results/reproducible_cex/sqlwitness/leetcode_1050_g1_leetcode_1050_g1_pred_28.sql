-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 4, 3), (1, 0, 0), (3, 2, 2), (4, NULL, 3), (0, 0, 1), (5, NULL, 4), (6, NULL, 2), (7, 1, NULL), (8, NULL, 3), (9, 4, 1), (10, NULL, 4), (11, 4, 3), (12, NULL, 2), (13, NULL, 0), (14, 2, 2), (15, 3, 0), (16, 4, 4), (17, 0, NULL), (18, 3, 3), (19, NULL, 2), (20, 1, 0), (21, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 3)
*/

-- Prediction Query
SELECT A.ACTOR_ID, A.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS CNT FROM ACTORDIRECTOR AS A GROUP BY ACTOR_ID, DIRECTOR_ID) AS A WHERE A.CNT >= 3;

/*
Prediction Result:
(None, 2)
(4, 3)
*/