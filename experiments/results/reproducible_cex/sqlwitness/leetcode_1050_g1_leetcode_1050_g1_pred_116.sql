-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 2, NULL), (2, 4, 1), (4, 1, 1), (3, 2, NULL), (1, 0, NULL), (5, 1, 2), (6, 0, 4), (7, 3, 0), (8, 0, 3), (9, 3, 4), (10, 2, NULL), (11, NULL, 2), (12, NULL, 1), (13, 0, 2), (14, 2, 2), (15, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID + DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/