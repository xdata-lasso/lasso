-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 2, 2), (0, 2, NULL), (2, 4, NULL), (3, 4, 2), (1, 3, NULL), (5, 0, NULL), (6, NULL, 3), (7, 0, 0), (8, NULL, 3), (9, 2, 2), (10, 4, NULL), (11, NULL, 4), (12, 0, 1), (13, 4, 2), (14, 1, 0), (15, NULL, NULL), (16, 1, 4), (17, 3, 4), (18, 1, 2), (19, 0, NULL), (20, 0, 3), (21, 4, 4), (22, NULL, 3), (23, NULL, 2), (24, 1, 0), (25, 0, 2), (26, 0, 3), (27, 1, 3), (28, 4, 1), (29, 3, NULL), (30, 4, 2), (31, 1, NULL), (32, 3, 4), (33, 0, 2), (34, 3, 1), (35, 0, 2), (36, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 2)
(4, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS C FROM ACTORDIRECTOR GROUP BY 1, 2) AS T WHERE C >= 3;

/*
Prediction Result:
(None, 3)
(0, 2)
(4, 2)
*/