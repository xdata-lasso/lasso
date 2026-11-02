-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 0, 3), (0, 3, 2), (3, 1, 3), (2, NULL, NULL), (4, 0, 1), (5, 2, 3), (6, NULL, 3), (7, NULL, 3), (8, NULL, 0), (9, NULL, 2), (10, NULL, 2), (11, 3, 2), (12, 2, 1), (13, 1, 1), (14, 2, 0), (15, 0, 3), (16, NULL, 3), (17, 3, NULL), (18, NULL, 2), (19, 0, 3), (20, 2, NULL), (21, 3, 2), (22, 0, 3), (23, 2, 2), (24, NULL, 0), (25, NULL, NULL), (26, 1, 3), (27, NULL, NULL), (28, 3, NULL), (29, 0, 3), (30, 3, 1), (31, 0, 3), (32, 2, 1), (33, 0, 2), (34, 2, 0), (35, 3, NULL), (36, 0, 0), (37, 1, 0), (38, NULL, NULL), (39, 1, 3), (40, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, None)
(3, 2)
(0, 3)
(1, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DISTINCT TIMESTAMP) > 2;

/*
Prediction Result:
(None, None)
(None, 2)
(None, 3)
(0, 3)
(1, 3)
(3, None)
(3, 2)
*/