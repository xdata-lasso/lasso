-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 4, 2), (0, 3, 4), (1, 3, 3), (2, 0, 2), (4, 2, 4), (5, NULL, NULL), (6, NULL, 3), (7, NULL, NULL), (8, 3, 1), (9, NULL, 0), (10, 3, 1), (11, NULL, 3), (12, 3, 2), (13, 2, 1), (14, 1, NULL), (15, 3, 4), (16, 1, 2), (17, 1, 2), (18, 3, 2), (19, 2, 4), (20, NULL, 1), (21, NULL, 4), (22, 4, NULL), (23, 1, 3), (24, 1, 1), (25, 4, 3), (26, 3, 3), (27, 0, NULL), (28, 0, 4), (29, 0, NULL), (30, NULL, NULL), (31, NULL, 2), (32, 3, NULL), (33, 3, 0), (34, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
WITH CNT AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS COOP FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) SELECT ACTOR_ID, DIRECTOR_ID FROM CNT WHERE COOP >= 3;

/*
Prediction Result:
(None, None)
*/