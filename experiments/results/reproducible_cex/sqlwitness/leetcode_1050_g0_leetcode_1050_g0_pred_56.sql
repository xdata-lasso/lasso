-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 0, 0), (2, 1, NULL), (1, 3, 0), (4, 2, 3), (3, 2, 0), (5, 4, 3), (6, 0, NULL), (7, 4, 2), (8, 2, 2), (9, 3, 4), (10, 1, 0), (11, 1, 0), (12, 1, 3), (13, NULL, 3), (14, 0, 2), (15, 3, 1), (16, 4, 3), (17, 1, NULL), (18, 1, NULL), (19, 1, NULL), (20, 1, NULL), (21, NULL, 3), (22, 4, 0), (23, 1, 3), (24, 3, 0), (25, 1, 3), (26, 3, 1), (27, 3, 0), (28, 1, 0), (29, 3, NULL), (30, 4, 2), (31, 0, 2), (32, 2, 2), (33, 2, 3), (34, NULL, 1), (35, 1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(1, None)
(1, 0)
(1, 3)
(3, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(1) >= 3 ORDER BY NULL, ACTOR_ID NULLS LAST, DIRECTOR_ID NULLS LAST;

/*
Prediction Result:
(1, 0)
(1, 3)
(1, None)
(3, 0)
*/