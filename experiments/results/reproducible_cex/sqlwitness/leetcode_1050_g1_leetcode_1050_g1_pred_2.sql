-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 2, 0), (2, 2, 3), (3, 3, 2), (0, 1, 0), (1, 0, NULL), (5, NULL, 3), (6, 3, 2), (7, 2, 1), (8, 3, 1), (9, 3, 2), (10, 4, 1), (11, NULL, 3), (12, NULL, 3), (13, 4, 1), (14, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 2)
*/

-- Prediction Query
SELECT X.ACTOR_ID, X.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(*) >= 3) AS X;

/*
Prediction Result:
(None, 3)
(3, 2)
*/