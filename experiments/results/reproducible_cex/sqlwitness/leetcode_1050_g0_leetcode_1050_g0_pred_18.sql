-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 4, 2), (1, 2, 0), (3, 4, 1), (0, 1, 3), (4, NULL, 4), (5, 3, 4), (6, 3, 0), (7, 0, NULL), (8, 0, 3), (9, 4, 1), (10, 0, 3), (11, 1, 0), (12, 0, NULL), (13, NULL, 2), (14, 2, 2), (15, NULL, 2), (16, 3, 3), (17, 3, 4), (18, 0, 4), (19, 0, NULL), (20, NULL, 1), (21, NULL, 4), (22, 1, 4), (23, 2, 0), (24, 1, NULL), (25, 4, 0), (26, 0, 1), (27, NULL, 0), (28, 0, 4), (29, 3, 3), (30, 3, NULL), (31, NULL, 0), (32, 2, NULL), (33, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/