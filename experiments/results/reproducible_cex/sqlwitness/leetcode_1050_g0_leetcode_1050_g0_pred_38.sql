-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 4, 4), (3, NULL, NULL), (0, NULL, 0), (1, 3, 2), (2, NULL, 1), (5, NULL, 2), (6, NULL, NULL), (7, NULL, 2), (8, 3, 2), (9, NULL, 2), (10, 1, 3), (11, 0, 2), (12, 0, 2), (13, 2, NULL), (14, 2, 3), (15, 0, 4), (16, 3, 3), (17, NULL, 3), (18, 0, 3), (19, 0, 1), (20, NULL, 2), (21, NULL, NULL), (22, 3, 1), (23, 1, 3), (24, 2, 1), (25, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, None)
(None, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID = DIRECTOR_ID) >= 3;

/*
Prediction Result:
*/