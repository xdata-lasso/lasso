-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 2, 0), (2, 4, 1), (0, 1, 0), (1, 0, 3), (3, 4, NULL), (5, 0, NULL), (6, 1, 3), (7, 2, 4), (8, 3, 1), (9, 2, 1), (10, 0, 2), (11, 2, 2), (12, 4, 3), (13, 0, 0), (14, NULL, 1), (15, NULL, 2), (16, 2, NULL), (17, 2, 2), (18, NULL, 2), (19, 1, 0), (20, 2, 3), (21, 2, 1), (22, 2, NULL), (23, 0, 3), (24, 0, NULL), (25, 2, NULL), (26, 3, 0), (27, 1, 0), (28, 1, 0), (29, 1, 2), (30, NULL, 4), (31, 1, 3), (32, NULL, 4), (33, 2, 1), (34, NULL, 2), (35, 2, NULL), (36, 1, 0), (37, 2, 1), (38, 0, NULL), (39, 0, 3), (40, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, None)
(2, None)
(1, 0)
(2, 1)
(0, 3)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID = DIRECTOR_ID) >= 3;

/*
Prediction Result:
(0, 3)
(1, 0)
(2, 1)
*/