-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 4, 2), (0, 3, NULL), (1, 3, 0), (2, NULL, 0), (3, 0, 1), (5, 3, 1), (6, 1, 2), (7, 1, 3), (8, 1, 4), (9, 2, 2), (10, 3, 1), (11, NULL, 2), (12, NULL, 1), (13, 2, 4), (14, 2, 0), (15, 4, NULL), (16, 1, 0), (17, NULL, 4), (18, 0, NULL), (19, NULL, 4), (20, NULL, 4), (21, NULL, 3), (22, NULL, 2), (23, 0, 2), (24, 3, 1), (25, 0, NULL), (26, 3, 3), (27, 0, 1), (28, 3, 0), (29, 4, 0), (30, 1, 4), (31, 0, 1), (32, 1, NULL), (33, 0, 2), (34, 2, 3), (35, NULL, 2), (36, 0, 3), (37, 0, 0), (38, 2, 3), (39, 0, 0), (40, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 2)
(None, 4)
(0, 1)
(3, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Prediction Result:
(0, 1)
(3, 1)
*/