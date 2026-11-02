-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 1, 2), (1, NULL, 2), (2, 2, NULL), (0, NULL, 0), (4, 2, 3), (5, NULL, 0), (6, NULL, 2), (7, 1, 0), (8, 0, 2), (9, 3, 1), (10, 0, 0), (11, 1, 2), (12, NULL, 2), (13, 1, 0), (14, NULL, NULL), (15, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DISTINCT (TIMESTAMP)) > 2;

/*
Prediction Result:
(None, 2)
*/