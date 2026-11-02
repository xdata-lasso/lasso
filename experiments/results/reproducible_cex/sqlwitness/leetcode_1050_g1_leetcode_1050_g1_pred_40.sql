-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 3, NULL), (0, 2, 2), (2, 3, 2), (3, 3, 2), (4, 3, NULL), (5, NULL, 1), (6, NULL, 1), (7, 4, 3), (8, 4, 3), (9, NULL, 4), (10, NULL, 1), (11, 0, NULL), (12, 1, 3), (13, 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DISTINCT (TIMESTAMP)) >= 3;

/*
Prediction Result:
(None, 1)
*/