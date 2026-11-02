-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, NULL, 2), (0, 1, NULL), (4, 1, 4), (2, NULL, 2), (3, NULL, 1), (5, 2, 3), (6, NULL, 0), (7, 0, 4), (8, NULL, 2), (9, 3, 0), (10, 2, 1), (11, 3, 1), (12, 3, 0), (13, 1, 3), (14, 2, 3), (15, 4, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.ACTOR_ID AS ACTOR_ID, A.DIRECTOR_ID AS DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS TOTAL FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING TOTAL >= 3) AS A;

/*
Prediction Result:
(None, 2)
*/