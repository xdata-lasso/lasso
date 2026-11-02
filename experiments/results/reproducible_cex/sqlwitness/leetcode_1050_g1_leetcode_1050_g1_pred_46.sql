-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 1, 3), (2, 3, 1), (0, 2, 4), (3, 4, 4), (1, 3, 2), (5, NULL, NULL), (6, 1, 3), (7, NULL, 2), (8, 1, 4), (9, 2, 2), (10, 0, 3), (11, NULL, 2), (12, 1, 0), (13, 0, 1), (14, 1, 3), (15, NULL, 2), (16, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, 3)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS CT FROM ACTORDIRECTOR) AS A WHERE CT >= 3;

/*
Prediction Result:
(None, 2)
(1, 3)
*/