-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 1, 0), (1, 3, NULL), (4, 3, 1), (0, 3, 2), (2, 0, NULL), (5, 3, 3), (6, 2, 3), (7, 0, 3), (8, 3, NULL), (9, 0, 2), (10, 0, 3), (11, 3, 4), (12, 3, NULL), (13, 1, 2), (14, 4, 4), (15, 2, 2), (16, 4, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(3, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) > 2;

/*
Prediction Result:
*/