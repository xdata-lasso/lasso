-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 1, 3), (0, 4, 0), (1, 0, 0), (4, 3, 1), (2, 2, NULL), (5, NULL, 1), (6, 1, 0), (7, 4, 2), (8, 0, 2), (9, NULL, 1), (10, 0, 2), (11, NULL, 0), (12, NULL, 0), (13, 2, 2), (14, 3, 3), (15, 2, 2), (16, 3, 1), (17, 1, 3), (18, 1, 4), (19, 1, 1), (20, 2, 0), (21, 4, 1), (22, 0, NULL), (23, 3, 4), (24, 1, 4), (25, NULL, 1), (26, NULL, NULL), (27, NULL, 0), (28, 3, 2), (29, NULL, 0), (30, NULL, 4), (31, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(1) >= 3 ORDER BY NULL, ACTOR_ID NULLS LAST, DIRECTOR_ID NULLS LAST;

/*
Prediction Result:
(None, 0)
(None, 1)
*/