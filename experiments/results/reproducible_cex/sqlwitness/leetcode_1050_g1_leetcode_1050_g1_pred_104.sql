-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 4, 4), (4, NULL, 1), (3, 4, 1), (2, 3, NULL), (1, 2, 0), (5, 2, NULL), (6, 3, NULL), (7, 3, 0), (8, 3, 0), (9, NULL, 3), (10, 1, 3), (11, 3, 4), (12, 2, 0), (13, 2, 2), (14, 3, 1), (15, 4, 3), (16, 3, 2), (17, 0, 2), (18, 4, 0), (19, 3, NULL), (20, NULL, 3), (21, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/