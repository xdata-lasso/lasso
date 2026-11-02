-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 0, 0), (4, 4, 4), (3, 4, 3), (1, NULL, 1), (2, 3, 2), (5, 4, 3), (6, 1, NULL), (7, NULL, 1), (8, 2, 4), (9, 1, 0), (10, 1, NULL), (11, 4, NULL), (12, 4, NULL), (13, 1, 0), (14, 4, 2), (15, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT D1.ACTOR_ID, D1.DIRECTOR_ID FROM ACTORDIRECTOR AS D1 GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/