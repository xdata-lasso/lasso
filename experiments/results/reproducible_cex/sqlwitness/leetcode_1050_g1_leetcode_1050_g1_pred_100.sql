-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, NULL, 1), (0, 2, 3), (1, 2, 2), (4, 1, NULL), (3, NULL, NULL), (5, NULL, 4), (6, NULL, NULL), (7, 3, 2), (8, 4, 2), (9, NULL, NULL), (10, 4, 3), (11, 0, 1), (12, 3, NULL), (13, 2, NULL), (14, 1, 2), (15, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS NUMBER_OF_TIMES FROM ACTORDIRECTOR) AS TEMP WHERE NUMBER_OF_TIMES >= 3;

/*
Prediction Result:
(None, None)
*/