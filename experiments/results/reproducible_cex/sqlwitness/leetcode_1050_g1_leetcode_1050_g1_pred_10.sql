-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 4, NULL), (3, 0, 2), (4, 3, 2), (1, 2, 4), (0, 4, 4), (5, 4, 2), (6, 1, 2), (7, 3, 3), (8, 3, 2), (9, 3, 0), (10, 4, 4), (11, 1, 1), (12, NULL, 2), (13, 3, 3), (14, NULL, 4), (15, 4, 3), (16, 3, 3), (17, 3, 4), (18, 0, 2), (19, 3, 2), (20, NULL, 4), (21, 0, 4), (22, NULL, 4), (23, NULL, NULL), (24, 0, NULL), (25, 3, 0), (26, NULL, 1), (27, 3, 4), (28, 2, 2), (29, 3, 3), (30, 0, 0), (31, 2, 3), (32, 2, NULL), (33, 3, 0), (34, 4, 1), (35, 0, 4), (36, 2, 0), (37, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 0)
(3, 2)
(3, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS TIMES FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS A WHERE A.TIMES >= 3;

/*
Prediction Result:
(None, 4)
(3, 0)
(3, 2)
(3, 3)
*/