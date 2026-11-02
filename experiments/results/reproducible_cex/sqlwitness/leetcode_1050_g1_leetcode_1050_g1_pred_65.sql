-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 4, 1), (0, 1, 0), (3, 0, NULL), (4, 1, 1), (2, 2, 4), (5, 2, 1), (6, 1, 2), (7, 0, 0), (8, 1, 4), (9, 4, 3), (10, NULL, 3), (11, 4, 4), (12, 1, 2), (13, 0, 1), (14, 3, 3), (15, 0, NULL), (16, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID || '*' || DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(0, None)
*/