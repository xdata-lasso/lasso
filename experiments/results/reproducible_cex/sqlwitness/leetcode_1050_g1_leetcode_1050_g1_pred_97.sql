-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, NULL, 0), (0, 3, 3), (4, NULL, 1), (2, 2, NULL), (3, 1, 2), (5, 2, 3), (6, NULL, 1), (7, 4, 4), (8, 1, 0), (9, 0, NULL), (10, NULL, 4), (11, 0, 2), (12, 2, 4), (13, 2, 2), (14, 2, 1), (15, 4, 4), (16, 1, 4), (17, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS SDF FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING SDF >= 3) AS S;

/*
Prediction Result:
(None, 1)
*/