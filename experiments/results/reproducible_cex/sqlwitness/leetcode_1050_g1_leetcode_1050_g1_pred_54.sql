-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 4, 0), (4, 2, 3), (0, 3, 3), (1, 4, 3), (3, 0, 0), (5, 4, 1), (6, NULL, 1), (7, 1, 3), (8, 2, NULL), (9, 0, 0), (10, 2, 0), (11, 0, 3), (12, 1, 1), (13, 3, 4), (14, 2, 2), (15, 1, 4), (16, 3, 2), (17, NULL, 4), (18, 4, 3), (19, 1, NULL), (20, 3, NULL), (21, 4, 0), (22, NULL, 4), (23, NULL, 4), (24, 0, 0), (25, 0, 2), (26, 4, 4), (27, 4, 1), (28, 3, NULL), (29, 4, 1), (30, 0, 3), (31, 0, 4), (32, 3, 4), (33, 2, 4), (34, 3, 4), (35, 0, 4), (36, 2, 4), (37, 4, 3), (38, 4, 0), (39, 2, 0), (40, 4, 4), (41, 3, 0), (42, 0, 2), (43, 2, 0), (44, NULL, 3), (45, 4, NULL), (46, 0, NULL), (47, NULL, 1), (48, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 0)
(2, 0)
(4, 0)
(4, 1)
(4, 3)
(3, 4)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR AS AD GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(1) >= 3;

/*
Prediction Result:
(None, 4)
(0, 0)
(2, 0)
(3, 4)
(4, 0)
(4, 1)
(4, 3)
*/