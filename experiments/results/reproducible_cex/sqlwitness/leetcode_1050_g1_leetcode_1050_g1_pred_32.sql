-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, NULL, 4), (0, 4, 4), (2, 3, NULL), (4, 0, 1), (3, NULL, 4), (5, NULL, 1), (6, 3, 4), (7, NULL, 2), (8, NULL, 0), (9, 0, NULL), (10, 1, 3), (11, NULL, 2), (12, 4, 0), (13, 0, 1), (14, 3, 2), (15, 4, 4), (16, NULL, 4), (17, 3, 0), (18, NULL, 4), (19, 0, 0), (20, NULL, 2), (21, 2, 3), (22, NULL, 1), (23, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS NUM_COOP FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS ANR_COUNTER WHERE NUM_COOP >= 3;

/*
Prediction Result:
(None, 2)
(None, 4)
(0, 1)
*/