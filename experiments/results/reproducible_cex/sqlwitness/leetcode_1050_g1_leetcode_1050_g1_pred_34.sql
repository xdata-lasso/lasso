-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 1, 4), (0, NULL, 1), (1, NULL, 0), (2, 0, 2), (4, 3, 2), (5, 0, NULL), (6, 3, 1), (7, 4, 0), (8, 1, 3), (9, 1, 3), (10, 3, 0), (11, NULL, 0), (12, 0, 4), (13, 1, NULL), (14, 4, 4), (15, 0, 0), (16, NULL, 0), (17, NULL, 3), (18, 1, 2), (19, 4, NULL), (20, 0, NULL), (21, NULL, 2), (22, 3, 1), (23, 4, 4), (24, 4, 3), (25, 3, 0), (26, 4, 1), (27, 4, 1), (28, 1, 4), (29, 2, NULL), (30, 1, 1), (31, 4, 1), (32, NULL, NULL), (33, 1, 3), (34, 2, 3), (35, 4, 3), (36, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 1)
(4, 1)
(1, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS COUNTS FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS T1 WHERE COUNTS >= 3;

/*
Prediction Result:
(None, 0)
(1, 3)
(3, 1)
(4, 1)
*/