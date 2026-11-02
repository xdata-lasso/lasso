-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, NULL, 0), (4, NULL, 0), (2, 2, 1), (1, 1, 3), (0, 0, 1), (5, 1, 1), (6, 3, NULL), (7, 2, 1), (8, 2, NULL), (9, NULL, 0), (10, 3, 0), (11, 0, 3), (12, 2, NULL), (13, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT A.ACTOR_ID, A.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS NUMS FROM ACTORDIRECTOR GROUP BY 1, 2) AS A WHERE NUMS >= 3;

/*
Prediction Result:
(None, 0)
(2, None)
*/