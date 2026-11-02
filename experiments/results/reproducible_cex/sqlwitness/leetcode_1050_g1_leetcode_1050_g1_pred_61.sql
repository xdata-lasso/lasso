-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 1, 0), (1, 1, -1), (3, NULL, NULL), (-1, -1, 0), (2, 0, 2), (4, -1, -1), (5, 2, 4), (6, 3, 2), (7, -1, NULL), (8, NULL, -1), (9, 3, 2), (10, 4, 4), (11, 4, 4), (12, 3, NULL), (13, NULL, 2), (14, 1, NULL), (15, NULL, NULL), (16, -1, 4), (17, 0, 0), (18, 3, 0), (19, -1, 4), (20, -1, 1), (21, 1, 2), (22, 3, -1), (23, 4, -1), (24, -1, 1), (25, -1, 0), (26, NULL, NULL), (27, 4, 3), (28, NULL, 3), (29, -1, 2), (30, -1, 0), (31, 3, 2), (32, -1, 0), (33, 2, 4), (34, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(-1, 0)
(3, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(0) >= 3;

/*
Prediction Result:
(None, None)
(-1, 0)
(3, 2)
*/