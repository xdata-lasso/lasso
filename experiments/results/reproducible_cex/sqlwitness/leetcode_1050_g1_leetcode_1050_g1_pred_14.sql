-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 0, 1), (3, 3, 0), (0, 2, NULL), (2, NULL, 4), (1, NULL, NULL), (5, 2, 2), (6, 2, 0), (7, 4, 1), (8, 3, 3), (9, 1, 1), (10, 0, NULL), (11, 1, 4), (12, 0, 3), (13, 4, 2), (14, 0, NULL), (15, 1, 1), (16, 2, 4), (17, 1, 4), (18, 0, 0), (19, 3, NULL), (20, 3, 3), (21, 0, NULL), (22, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID || DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/