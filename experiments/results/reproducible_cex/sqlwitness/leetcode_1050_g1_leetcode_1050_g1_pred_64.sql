-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 2, 2), (1, NULL, 0), (0, 3, 1), (3, NULL, 0), (2, 1, 0), (5, NULL, 0), (6, 2, 0), (7, 3, 2), (8, 4, 4), (9, NULL, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS COUNT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS X WHERE X.COUNT >= 3;

/*
Prediction Result:
(None, 0)
*/