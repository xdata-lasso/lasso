-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 0, NULL), (0, NULL, NULL), (1, 2, 1), (2, 0, 2), (4, 2, 3), (5, NULL, 0), (6, 1, NULL), (7, 3, NULL), (8, 0, 1), (9, 1, 0), (10, 2, 2), (11, NULL, 1), (12, NULL, 1), (13, NULL, 1), (14, 1, 1), (15, 0, 2), (16, 2, 2), (17, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS CNT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING CNT > 2) AS TAB;

/*
Prediction Result:
(None, 1)
(0, 2)
*/