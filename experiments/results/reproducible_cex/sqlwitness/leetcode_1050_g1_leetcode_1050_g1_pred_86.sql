-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, NULL, 4), (0, 3, 3), (4, 1, 4), (1, 3, 2), (2, 2, 1), (5, 3, 1), (6, 0, 4), (7, 4, 3), (8, NULL, 4), (9, NULL, 0), (10, NULL, 2), (11, NULL, 1), (12, 0, 4), (13, 1, 3), (14, 0, 0), (15, 4, NULL), (16, 2, 4), (17, 4, 4), (18, 3, NULL), (19, 4, NULL), (20, 1, 3), (21, NULL, 1), (22, 3, 4), (23, 1, 1), (24, NULL, 4), (25, 2, 4), (26, 2, 1), (27, 2, NULL), (28, NULL, 0), (29, 1, 4), (30, NULL, 1), (31, 2, 2), (32, 2, 3), (33, NULL, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.ACTOR_ID, A.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS NUM FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING NUM >= 3) AS A;

/*
Prediction Result:
(None, 1)
(None, 4)
*/