-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, NULL, 0), (2, 4, 3), (1, 1, 0), (3, 4, 2), (0, 3, 2), (5, 2, 3), (6, 2, 2), (7, 4, 2), (8, 0, 0), (9, 2, 1), (10, 4, 1), (11, 1, 3), (12, 3, 4), (13, 4, 2), (14, 3, 0), (15, 0, 2), (16, NULL, 0), (17, NULL, 0), (18, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 0)
(4, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID + DIRECTOR_ID) >= 3;

/*
Prediction Result:
(4, 2)
*/