-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, NULL, NULL), (0, NULL, NULL), (1, 4, 0), (4, 3, 0), (3, 3, 3), (5, 2, 2), (6, 3, 3), (7, 4, 1), (8, 3, NULL), (9, 0, 0), (10, 2, 4), (11, 2, 0), (12, NULL, NULL), (13, 1, 3), (14, 4, 4), (15, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS COUNTNUM FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS TEM WHERE COUNTNUM >= 3;

/*
Prediction Result:
(None, None)
*/