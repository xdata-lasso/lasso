-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 0, 1), (1, 4, 3), (2, 0, 2), (0, 3, NULL), (3, 3, NULL), (5, 0, 1), (6, 0, 3), (7, 4, 1), (8, 2, 0), (9, NULL, 3), (10, 1, 0), (11, NULL, 3), (12, NULL, 3), (13, 1, 1), (14, 4, 3), (15, 0, 4), (16, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
WITH COUNT_TABLE AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS NUM_COOPERATED FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) >= 3) SELECT ACTOR_ID, DIRECTOR_ID FROM COUNT_TABLE;

/*
Prediction Result:
(None, 3)
*/