-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 4, NULL), (0, 4, 4), (3, 3, NULL), (4, NULL, NULL), (2, 0, NULL), (5, NULL, 1), (6, NULL, 1), (7, 0, NULL), (8, NULL, 1), (9, 3, 3), (10, 2, 1), (11, 4, 2), (12, 3, NULL), (13, 4, 0), (14, 3, 0), (15, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Prediction Result:
*/