-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 0, NULL), (2, 3, 0), (4, 2, 1), (3, 1, 0), (1, NULL, 0), (5, 4, NULL), (6, 3, 2), (7, NULL, 2), (8, NULL, 2), (9, 4, 1), (10, 0, 2), (11, 1, 1), (12, 2, 4), (13, 2, NULL), (14, 3, 4), (15, NULL, 2), (16, 2, 4), (17, 4, 0), (18, 0, 3), (19, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS CNT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING CNT >= 3) AS C;

/*
Prediction Result:
(None, 2)
*/