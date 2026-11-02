-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 2, 2), (3, 3, NULL), (2, 1, 3), (0, 0, 2), (1, 4, 2), (5, 4, 3), (6, 3, 4), (7, 1, 0), (8, NULL, 1), (9, 2, NULL), (10, NULL, 1), (11, 0, 4), (12, 2, 1), (13, 3, 0), (14, 3, NULL), (15, 4, 3), (16, 2, NULL), (17, 4, 3), (18, 3, 3), (19, 4, 3), (20, 3, 0), (21, 3, 2), (22, 1, 1), (23, 2, 1), (24, 4, 3), (25, 0, NULL), (26, 0, 4), (27, 1, NULL), (28, NULL, 1), (29, 0, NULL), (30, NULL, 3), (31, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 3)
*/

-- Prediction Query
WITH CNT_CO AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS CNT_TIME FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) SELECT ACTOR_ID, DIRECTOR_ID FROM CNT_CO WHERE CNT_TIME >= 3;

/*
Prediction Result:
(None, 1)
(4, 3)
*/