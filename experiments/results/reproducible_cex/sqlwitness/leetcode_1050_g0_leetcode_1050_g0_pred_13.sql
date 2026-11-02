-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 1, 2), (1, NULL, 1), (0, 0, NULL), (4, 3, 3), (2, NULL, 2), (5, 1, 2), (6, 2, NULL), (7, 3, 1), (8, NULL, 2), (9, 0, 4), (10, 3, 3), (11, 2, 3), (12, 3, NULL), (13, 4, 0), (14, 4, 3), (15, 4, NULL), (16, 4, 2), (17, 2, 4), (18, 2, NULL), (19, 2, 1), (20, 1, NULL), (21, 3, 0), (22, 0, NULL), (23, 4, 4), (24, 1, NULL), (25, 2, 4), (26, 1, 0), (27, 0, 2), (28, 3, 3), (29, 2, 4), (30, 2, 1), (31, NULL, 2), (32, NULL, 1), (33, NULL, 3), (34, 1, 0), (35, 3, 4), (36, 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 2)
(2, 4)
(3, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID || DIRECTOR_ID) >= 3;

/*
Prediction Result:
(2, 4)
(3, 3)
*/