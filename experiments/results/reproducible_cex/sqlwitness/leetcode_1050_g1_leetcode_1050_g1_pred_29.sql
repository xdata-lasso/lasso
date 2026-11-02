-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 0, 2), (1, NULL, 0), (4, 1, 3), (3, 0, 1), (2, NULL, 4), (5, 4, 0), (6, 3, 4), (7, NULL, 0), (8, 1, 2), (9, 1, 1), (10, NULL, 3), (11, 3, 4), (12, NULL, 2), (13, 3, NULL), (14, NULL, 3), (15, 4, 1), (16, 3, NULL), (17, 4, 1), (18, 4, 3), (19, 0, 4), (20, 3, 3), (21, 0, 1), (22, 0, 4), (23, NULL, 2), (24, 4, NULL), (25, 2, NULL), (26, 4, 2), (27, 0, 2), (28, 3, NULL), (29, 4, 3), (30, 3, 3), (31, 1, 4), (32, 0, 1), (33, 3, 4), (34, 3, 4), (35, 0, 2), (36, 2, 3), (37, NULL, 3), (38, 0, 4), (39, 2, 2), (40, 0, NULL), (41, 0, 3), (42, NULL, NULL), (43, 2, 1), (44, 0, 4), (45, 1, 1), (46, 3, 0), (47, 4, 2), (48, 3, 3), (49, 4, 4), (50, NULL, 4), (51, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, None)
(0, 1)
(0, 2)
(3, 3)
(0, 4)
(3, 4)
*/

-- Prediction Query
SELECT A1.ACTOR_ID, A1.DIRECTOR_ID FROM ACTORDIRECTOR AS A1 GROUP BY A1.ACTOR_ID, A1.DIRECTOR_ID HAVING COUNT(A1.TIMESTAMP) >= 3;

/*
Prediction Result:
(None, 3)
(0, 1)
(0, 2)
(0, 4)
(3, None)
(3, 3)
(3, 4)
*/