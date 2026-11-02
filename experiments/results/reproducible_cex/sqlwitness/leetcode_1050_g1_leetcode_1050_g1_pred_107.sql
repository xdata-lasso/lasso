-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 1, 3), (0, 1, 3), (3, 4, 4), (2, 3, 3), (4, 0, 0), (5, 4, 2), (6, NULL, 3), (7, NULL, 3), (8, NULL, NULL), (9, 1, 3), (10, 2, 3), (11, NULL, 1), (12, 4, 1), (13, 4, 3), (14, NULL, 0), (15, 1, 2), (16, NULL, 2), (17, 1, NULL), (18, 4, 3), (19, NULL, 2), (20, 3, 4), (21, NULL, 4), (22, 0, 2), (23, NULL, NULL), (24, 2, 4), (25, NULL, 1), (26, 2, 3), (27, 1, 3), (28, 3, 3), (29, 4, 3), (30, 0, 0), (31, 4, NULL), (32, 3, 0), (33, 4, 3), (34, 3, 3), (35, 3, 0), (36, 4, 1), (37, 1, 1), (38, 1, 4), (39, 0, 1), (40, 3, NULL), (41, 0, NULL), (42, 4, 2), (43, 3, 0), (44, 1, 1), (45, 3, 0), (46, 1, 0), (47, 2, 0), (48, NULL, 1), (49, 2, 2), (50, 4, 1), (51, 0, NULL), (52, 2, 0), (53, 0, 1), (54, 0, NULL), (55, 1, 3), (56, 2, 4), (57, 0, 4), (58, 0, NULL), (59, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, None)
(3, 0)
(4, 1)
(1, 3)
(3, 3)
(4, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(DIRECTOR_ID) OVER (PARTITION BY ACTOR_ID) AS CNT FROM ACTORDIRECTOR) AS T GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(CNT) >= 3;

/*
Prediction Result:
(None, 1)
(0, None)
(1, 3)
(3, 0)
(3, 3)
(4, 1)
(4, 3)
*/