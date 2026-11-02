-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 0, 2), (0, 0, 0), (1, 4, 0), (4, 2, 3), (2, 1, 2), (5, 2, 4), (6, 4, 2), (7, 3, 2), (8, 0, 0), (9, 2, NULL), (10, 4, NULL), (11, 2, 1), (12, NULL, 3), (13, NULL, 3), (14, NULL, 2), (15, 4, 4), (16, 0, 2), (17, 2, 1), (18, 2, NULL), (19, 2, 1), (20, 3, 3), (21, 3, NULL), (22, 2, NULL), (23, 0, 0), (24, 2, NULL), (25, 0, 0), (26, 0, 1), (27, 4, NULL), (28, NULL, 3), (29, 2, 2), (30, 1, 0), (31, 3, 0), (32, 3, 2), (33, 2, 0), (34, 0, 0), (35, NULL, NULL), (36, 4, 0), (37, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 3)
(0, 0)
(2, None)
(2, 1)
*/

-- Prediction Query
SELECT AD.ACTOR_ID, AD.DIRECTOR_ID FROM ACTORDIRECTOR AS AD GROUP BY AD.DIRECTOR_ID, ACTOR_ID HAVING COUNT(AD.ACTOR_ID) >= 3;

/*
Prediction Result:
(2, None)
(0, 0)
(2, 1)
*/