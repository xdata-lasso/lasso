-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, NULL, 0), (3, 4, 0), (2, 3, 1), (1, 0, 0), (4, 4, NULL), (5, 4, 2), (6, 1, 3), (7, 1, 4), (8, 4, NULL), (9, 0, 2), (10, 0, 4), (11, 4, 3), (12, 3, 1), (13, 4, NULL), (14, 3, 4), (15, 0, 0), (16, 1, 3), (17, 4, 0), (18, 4, 0), (19, NULL, 1), (20, 2, 1), (21, 0, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, None)
(4, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID) >= 3 AND COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
(4, 0)
*/