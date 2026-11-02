-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, NULL, 0), (4, NULL, 4), (2, 4, NULL), (3, 0, 3), (0, 3, 0), (5, 2, 0), (6, 1, 3), (7, 1, 0), (8, 2, 2), (9, 1, 2), (10, 4, NULL), (11, NULL, 1), (12, 0, 3), (13, 1, NULL), (14, NULL, 4), (15, NULL, 0), (16, NULL, 0), (17, 3, 1), (18, 4, 3), (19, 0, 4), (20, 3, 4), (21, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT AD.ACTOR_ID, AD.DIRECTOR_ID FROM ACTORDIRECTOR AS AD GROUP BY AD.ACTOR_ID, AD.DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 0)
*/