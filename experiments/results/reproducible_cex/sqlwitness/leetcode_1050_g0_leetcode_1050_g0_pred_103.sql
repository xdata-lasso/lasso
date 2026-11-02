-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, NULL, NULL), (4, 3, 3), (2, NULL, NULL), (1, 2, 2), (0, 2, 4), (5, 4, 2), (6, NULL, NULL), (7, 2, NULL), (8, NULL, 0), (9, 4, 2), (10, 1, 4), (11, 1, 2), (12, 2, 2), (13, 2, 1), (14, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/