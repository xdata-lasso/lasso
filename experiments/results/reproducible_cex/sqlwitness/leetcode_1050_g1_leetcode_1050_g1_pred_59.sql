-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 0, 0), (2, 3, 2), (3, NULL, 0), (0, 1, 2), (4, 2, 0), (5, NULL, NULL), (6, 0, 2), (7, 0, 0), (8, 3, 0), (9, 1, 1), (10, 2, 1), (11, NULL, 0), (12, 0, NULL), (13, NULL, 1), (14, 1, 0), (15, 3, 3), (16, 0, 1), (17, NULL, NULL), (18, NULL, 1), (19, NULL, 0), (20, 0, 2), (21, 1, NULL), (22, 0, NULL), (23, 1, 2), (24, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.ACTOR_ID, A.DIRECTOR_ID FROM ACTORDIRECTOR AS A GROUP BY A.ACTOR_ID, A.DIRECTOR_ID HAVING COUNT(A.TIMESTAMP) > 2;

/*
Prediction Result:
(None, 0)
*/