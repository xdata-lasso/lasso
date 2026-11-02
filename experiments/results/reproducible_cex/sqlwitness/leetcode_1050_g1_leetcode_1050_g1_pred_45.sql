-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, NULL, NULL), (4, 2, 1), (2, NULL, NULL), (1, 3, 4), (3, NULL, 4), (5, 1, 0), (6, 4, 2), (7, 0, 0), (8, 1, 1), (9, NULL, NULL), (10, NULL, 3), (11, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.ACTOR_ID, A.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(DISTINCT TIMESTAMP) AS CO_TIMES FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS A WHERE CO_TIMES >= 3;

/*
Prediction Result:
(None, None)
*/