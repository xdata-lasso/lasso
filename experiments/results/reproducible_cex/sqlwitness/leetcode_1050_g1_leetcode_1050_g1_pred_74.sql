-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 4, 0), (4, NULL, 1), (1, 3, NULL), (0, 1, NULL), (3, 2, 1), (5, 3, 0), (6, 1, 2), (7, 3, 0), (8, 1, 4), (9, 3, 2), (10, 4, 2), (11, 4, 1), (12, 4, 4), (13, 3, 1), (14, NULL, 3), (15, 1, NULL), (16, 2, 3), (17, 0, 4), (18, 3, 4), (19, NULL, 3), (20, 2, 2), (21, 1, NULL), (22, 3, NULL), (23, 0, 3), (24, 2, 0), (25, NULL, NULL), (26, 3, 0), (27, 3, 0), (28, 4, 0), (29, 0, 2), (30, 4, 3), (31, 3, NULL), (32, NULL, 0), (33, 0, 2), (34, 2, 2), (35, 2, 4), (36, 1, NULL), (37, 1, NULL), (38, 0, 0), (39, 3, 4), (40, 3, 1), (41, 2, 2), (42, 3, NULL), (43, 2, 2), (44, 2, NULL), (45, 1, 4), (46, 4, 4), (47, NULL, 3), (48, 0, 0), (49, 3, 0), (50, 3, NULL), (51, 0, 0), (52, 4, 1), (53, 1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
(3, None)
(0, 0)
(3, 0)
(2, 2)
(1, 4)
*/

-- Prediction Query
SELECT DISTINCT AD.ACTOR_ID, AD.DIRECTOR_ID FROM ACTORDIRECTOR AS AD GROUP BY AD.ACTOR_ID, AD.DIRECTOR_ID HAVING COUNT(AD.TIMESTAMP) >= 3;

/*
Prediction Result:
(None, 3)
(0, 0)
(1, None)
(1, 4)
(2, 2)
(3, None)
(3, 0)
*/