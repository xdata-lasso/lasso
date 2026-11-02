-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 1, 2), (4, 3, NULL), (0, NULL, NULL), (3, 4, 3), (1, 2, 4), (5, 0, 2), (6, 3, 1), (7, NULL, 2), (8, NULL, 2), (9, NULL, 2), (10, 3, 4), (11, 0, 1), (12, 3, NULL), (13, 0, 2), (14, 1, 3), (15, 0, 3), (16, 2, NULL), (17, 4, 1), (18, 3, 4), (19, NULL, 4), (20, 0, 0), (21, 0, 2), (22, 4, 0), (23, 0, 3), (24, 1, 1), (25, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 2)
*/

-- Prediction Query
SELECT C.ACTOR_ID, C.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS NUM_COOP FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) >= 3) AS C;

/*
Prediction Result:
(None, 2)
(0, 2)
*/