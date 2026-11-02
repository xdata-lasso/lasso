-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 1, 3), (2, 4, NULL), (1, 3, NULL), (4, 2, NULL), (3, 2, 0), (5, NULL, 0), (6, NULL, 0), (7, NULL, 4), (8, 2, NULL), (9, 0, 4), (10, 4, 0), (11, 1, 4), (12, 1, 0), (13, NULL, 0), (14, 3, 4), (15, 4, 3), (16, NULL, 4), (17, NULL, 2), (18, 1, 2), (19, 4, 0), (20, 0, 1), (21, 3, 0), (22, 2, 3), (23, 2, 2), (24, NULL, 0), (25, 4, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 0)
*/