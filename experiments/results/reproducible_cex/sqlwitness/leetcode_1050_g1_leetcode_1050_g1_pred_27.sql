-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 0, 0), (3, 1, NULL), (4, 4, 1), (2, 3, 2), (1, 1, 4), (5, 4, 4), (6, 2, 1), (7, NULL, 2), (8, 0, 4), (9, 1, 2), (10, NULL, 2), (11, 1, 2), (12, 0, 3), (13, 4, 4), (14, 4, 0), (15, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.ACTOR_ID, A.DIRECTOR_ID FROM ACTORDIRECTOR AS A GROUP BY 1, 2 HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 2)
*/