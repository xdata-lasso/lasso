-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 2, 0), (1, NULL, NULL), (3, 0, 2), (0, 1, 2), (4, 2, NULL), (5, 2, 2), (6, 3, 0), (7, 1, 1), (8, NULL, 3), (9, NULL, NULL), (10, NULL, 3), (11, 3, 3), (12, 3, 3), (13, 0, 1), (14, 1, 1), (15, 1, NULL), (16, 2, 0), (17, 2, 3), (18, 2, 0), (19, 3, 1), (20, 0, 3), (21, 2, NULL), (22, NULL, 3), (23, 3, 0), (24, 1, 1), (25, 2, 2), (26, 0, 3), (27, 2, 1), (28, 0, 2), (29, 3, 3), (30, NULL, 1), (31, 1, 1), (32, 2, 3), (33, 0, 1), (34, 1, 2), (35, 2, 3), (36, 0, 2), (37, 0, 0), (38, 2, 3), (39, 0, 2), (40, 2, 3), (41, NULL, 2), (42, 3, 3), (43, 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, 0)
(1, 1)
(0, 2)
(0, 3)
(2, 3)
(3, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS TIMES FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS T WHERE TIMES > 2;

/*
Prediction Result:
(None, 3)
(0, 2)
(0, 3)
(1, 1)
(2, 0)
(2, 3)
(3, 3)
*/