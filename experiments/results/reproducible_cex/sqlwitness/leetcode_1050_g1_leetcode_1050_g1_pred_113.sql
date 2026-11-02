-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 3, 2), (3, 1, 0), (2, 0, 1), (4, NULL, 4), (1, 1, 1), (5, 2, 2), (6, NULL, 0), (7, 0, 2), (8, NULL, 4), (9, 4, 3), (10, 0, 3), (11, 4, 2), (12, NULL, 0), (13, NULL, 3), (14, 1, NULL), (15, 2, 3), (16, 1, 0), (17, 2, 2), (18, 1, 0), (19, 0, NULL), (20, 2, 1), (21, 2, 1), (22, 0, 3), (23, NULL, 0), (24, 1, 1), (25, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, 0)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DISTINCT TIMESTAMP) >= 3;

/*
Prediction Result:
(None, 0)
(1, 0)
*/