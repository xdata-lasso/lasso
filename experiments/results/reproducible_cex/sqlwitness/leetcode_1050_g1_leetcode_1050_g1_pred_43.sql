-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, NULL, NULL), (1, 4, 0), (4, 1, 0), (0, 4, 3), (2, NULL, NULL), (5, NULL, 0), (6, 3, 4), (7, 0, 3), (8, 4, 0), (9, 0, NULL), (10, 2, 1), (11, NULL, 3), (12, 4, 2), (13, NULL, NULL), (14, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT('TIMESTAMP') >= 3;

/*
Prediction Result:
(None, None)
(4, 0)
*/