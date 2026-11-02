-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 2, 2), (1, 2, 4), (2, 3, 3), (3, NULL, 3), (0, 0, 0), (5, 3, 2), (6, NULL, 3), (7, 0, 1), (8, 0, NULL), (9, 3, 1), (10, 1, 2), (11, 2, 1), (12, NULL, NULL), (13, 0, 3), (14, 1, NULL), (15, NULL, 4), (16, NULL, NULL), (17, 0, 3), (18, 4, 0), (19, 4, 3), (20, NULL, 4), (21, 0, 4), (22, 4, 1), (23, NULL, 4), (24, 2, 2), (25, 3, 4), (26, 2, 0), (27, 0, 0), (28, 1, 4), (29, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.ACTOR_ID, A.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS NUM FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS A WHERE A.NUM >= 3;

/*
Prediction Result:
(None, 4)
*/