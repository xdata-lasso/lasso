-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 1, 4), (1, 1, 2), (4, 4, 4), (2, 0, 4), (0, NULL, 4), (5, 1, 1), (6, NULL, NULL), (7, 4, NULL), (8, NULL, NULL), (9, NULL, NULL), (10, NULL, 4), (11, 4, 2), (12, NULL, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, (DIRECTOR_ID) FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, None)
(None, 4)
*/