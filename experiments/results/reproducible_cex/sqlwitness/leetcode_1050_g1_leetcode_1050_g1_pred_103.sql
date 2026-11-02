-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 3, 2), (0, NULL, 0), (1, 1, 2), (3, 3, NULL), (4, 2, 2), (5, 0, NULL), (6, NULL, 1), (7, 2, 0), (8, NULL, 1), (9, NULL, 1), (10, 3, 1), (11, 3, NULL), (12, NULL, 3), (13, 2, 0), (14, NULL, 1), (15, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS NUMCOUNT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS MEETS WHERE NUMCOUNT > 2;

/*
Prediction Result:
(None, 1)
(2, 0)
*/