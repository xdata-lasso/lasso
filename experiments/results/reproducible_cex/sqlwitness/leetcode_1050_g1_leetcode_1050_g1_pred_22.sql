-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 2, 2), (3, NULL, 4), (0, 1, 3), (2, 3, 0), (4, NULL, 4), (5, 4, 4), (6, 2, NULL), (7, 1, 3), (8, 3, 4), (9, 1, NULL), (10, 3, 4), (11, NULL, NULL), (12, 1, 3), (13, NULL, 4), (14, 2, 4), (15, 3, 1), (16, NULL, NULL), (17, 1, 1), (18, 2, 2), (19, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR AS A GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DISTINCT TIMESTAMP) >= 3;

/*
Prediction Result:
(None, 4)
(1, 3)
*/