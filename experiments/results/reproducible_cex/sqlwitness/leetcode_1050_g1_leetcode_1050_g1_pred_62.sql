-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 0, 0), (1, NULL, 4), (4, 3, NULL), (2, NULL, 3), (3, 1, NULL), (5, 2, 3), (6, 4, 2), (7, 1, 4), (8, NULL, NULL), (9, NULL, 1), (10, NULL, 3), (11, 1, 2), (12, 4, 0), (13, 4, 3), (14, NULL, 2), (15, 4, 2), (16, 3, 0), (17, 1, 2), (18, 3, 2), (19, 1, NULL), (20, NULL, 4), (21, NULL, 4), (22, NULL, NULL), (23, 4, 0), (24, NULL, 3), (25, 1, 3), (26, 2, NULL), (27, NULL, NULL), (28, 4, 1), (29, 4, 1), (30, 0, 4), (31, 4, 2), (32, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS C FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS T1 WHERE C >= 3;

/*
Prediction Result:
(None, None)
(None, 3)
(None, 4)
(4, 2)
*/