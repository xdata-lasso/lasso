-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 4, 3), (3, 0, NULL), (4, 1, NULL), (0, 4, 4), (2, 0, 3), (5, 3, 0), (6, 1, 3), (7, 0, 4), (8, NULL, 2), (9, 4, 1), (10, 2, 1), (11, NULL, 3), (12, NULL, 4), (13, 1, NULL), (14, 1, 4), (15, NULL, 4), (16, NULL, NULL), (17, 0, NULL), (18, 1, 3), (19, 1, 1), (20, 4, 0), (21, 2, 2), (22, 4, 1), (23, 1, 1), (24, 2, 4), (25, 4, 2), (26, 2, 0), (27, 1, 3), (28, 2, NULL), (29, 4, NULL), (30, 4, 0), (31, 2, 0), (32, 1, NULL), (33, NULL, 1), (34, 3, 4), (35, 4, 1), (36, 3, 1), (37, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
(4, 1)
(1, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, TIMESTAMP FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3) AS A;

/*
Prediction Result:
(1, 3)
(4, 1)
*/