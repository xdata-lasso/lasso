-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 3, 3), (2, 3, 0), (3, 3, 1), (1, 1, 2), (4, NULL, 0), (5, 1, NULL), (6, 3, 0), (7, 2, 3), (8, 0, 3), (9, NULL, 0), (10, NULL, NULL), (11, 2, 3), (12, 3, 0), (13, 2, 2), (14, 1, 3), (15, 2, 2), (16, 0, 3), (17, 1, 2), (18, 2, 0), (19, 0, 1), (20, 0, 3), (21, 2, 1), (22, 3, 0), (23, NULL, 0), (24, 1, 2), (25, 1, 3), (26, 1, 0), (27, NULL, 1), (28, 1, NULL), (29, 1, 1), (30, NULL, NULL), (31, 3, 3), (32, NULL, NULL), (33, 1, 1), (34, 3, 0), (35, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 0)
(1, 2)
(0, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT('ACTOR_ID' || 'DIRECTOR_ID') > 2;

/*
Prediction Result:
(None, None)
(None, 0)
(0, 3)
(1, 2)
(3, 0)
*/