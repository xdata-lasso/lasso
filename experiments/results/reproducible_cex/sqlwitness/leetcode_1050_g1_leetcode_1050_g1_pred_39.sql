-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 0, 3), (0, 4, 1), (4, NULL, 4), (3, 1, 4), (1, 2, NULL), (5, 3, 3), (6, 1, 1), (7, 1, NULL), (8, NULL, 3), (9, 4, 0), (10, 1, NULL), (11, 1, 0), (12, 2, 0), (13, 2, 3), (14, 0, 2), (15, 1, 2), (16, 3, 2), (17, 0, NULL), (18, 0, 1), (19, 1, NULL), (20, 0, 3), (21, 1, 3), (22, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID = DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/