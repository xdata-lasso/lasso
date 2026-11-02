-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 2, 1), (1, 1, 1), (2, 1, NULL), (3, 4, 3), (0, 3, 4), (5, 4, 4), (6, 0, 2), (7, 2, 0), (8, 0, 1), (9, 0, NULL), (10, NULL, NULL), (11, NULL, NULL), (12, 1, 2), (13, 1, 0), (14, 1, 3), (15, NULL, 0), (16, 4, 0), (17, 4, 1), (18, 2, 4), (19, 3, 3), (20, NULL, 2), (21, NULL, NULL), (22, 3, 1), (23, NULL, 0), (24, 1, NULL), (25, 4, 0), (26, 4, 0), (27, 4, 3), (28, 3, 4), (29, 3, 2), (30, 0, 4), (31, 3, NULL), (32, 2, 4), (33, 4, 4), (34, 0, 0), (35, 2, 4), (36, 4, 0), (37, NULL, 2), (38, 2, NULL), (39, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 0)
(2, 4)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS TIMES FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS TIMESTABLE WHERE TIMES >= 3;

/*
Prediction Result:
(None, None)
(2, 4)
(4, 0)
*/