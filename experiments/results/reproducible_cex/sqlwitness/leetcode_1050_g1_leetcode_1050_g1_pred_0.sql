-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 2, 0), (0, 0, 0), (2, 0, 2), (3, 0, 0), (4, 3, 3), (5, NULL, 3), (6, NULL, NULL), (7, 2, 2), (8, 1, 1), (9, NULL, 1), (10, 0, 0), (11, NULL, NULL), (12, 2, 0), (13, NULL, NULL), (14, NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) > 2;

/*
Prediction Result:
(None, None)
(0, 0)
*/