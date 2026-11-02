-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 3, -1), (-1, 2, 2), (4, 2, NULL), (1, 0, NULL), (2, 2, NULL), (3, -1, 2), (5, 2, -1), (6, 0, NULL), (7, 0, -1), (8, 2, 4), (9, 0, -1), (10, 3, 2), (11, -1, 0), (12, 4, 1), (13, NULL, NULL), (14, 3, NULL), (15, -1, 0), (16, 4, 3), (17, 2, 2), (18, 2, NULL), (19, 0, 1), (20, 2, 1), (21, -1, NULL), (22, -1, -1), (23, 3, NULL), (24, 1, 1), (25, 0, 4), (26, 4, 1), (27, 4, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID - DIRECTOR_ID = 0) >= 3;

/*
Prediction Result:
*/