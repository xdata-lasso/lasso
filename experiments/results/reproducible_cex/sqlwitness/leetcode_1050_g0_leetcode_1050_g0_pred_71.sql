-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 0, NULL), (2, NULL, 0), (4, 3, 3), (1, 2, NULL), (3, 2, 0), (5, 4, 0), (6, 1, 4), (7, 0, 3), (8, NULL, 0), (9, 1, 3), (10, 1, 2), (11, 1, 3), (12, 1, NULL), (13, NULL, 2), (14, 0, NULL), (15, 4, 2), (16, 0, 1), (17, 1, 0), (18, 0, 0), (19, 0, NULL), (20, NULL, 0), (21, 4, 4), (22, 1, NULL), (23, 1, 4), (24, 0, 4), (25, NULL, 2), (26, 3, 4), (27, 3, 1), (28, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 0)
(0, None)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID = DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/