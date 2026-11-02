-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, NULL, 3), (0, 0, 3), (3, 1, 4), (2, 3, 3), (1, 4, 3), (5, 4, 2), (6, 4, 1), (7, 0, 2), (8, 0, 0), (9, 4, NULL), (10, 0, 0), (11, NULL, NULL), (12, 1, NULL), (13, 4, NULL), (14, 4, 0), (15, 3, 0), (16, NULL, 1), (17, 2, 4), (18, 3, 3), (19, NULL, 0), (20, 2, 0), (21, 0, NULL), (22, NULL, 3), (23, 1, 4), (24, NULL, 1), (25, 2, 0), (26, NULL, 1), (27, 4, 1), (28, 3, 0), (29, 4, 4), (30, 1, 2), (31, 1, 3), (32, 2, 0), (33, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT COUNT(*) AS CNT, ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING CNT >= 3) AS FYI;

/*
Prediction Result:
(None, 1)
(2, 0)
*/