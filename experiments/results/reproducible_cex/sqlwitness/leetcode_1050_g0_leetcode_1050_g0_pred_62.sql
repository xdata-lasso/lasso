-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 0, 4), (0, 1, 0), (1, 4, NULL), (3, 3, 0), (4, 4, 1), (5, 2, 0), (6, 1, 2), (7, 3, 2), (8, 0, 3), (9, 4, NULL), (10, 2, 3), (11, 3, 2), (12, 2, 3), (13, 2, 3), (14, 3, 4), (15, 3, NULL), (16, 1, 0), (17, NULL, 1), (18, 3, 3), (19, 4, NULL), (20, 4, 1), (21, 1, 0), (22, 0, 3), (23, NULL, NULL), (24, 0, 1), (25, 0, 1), (26, NULL, 4), (27, 2, NULL), (28, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(1, 0)
(2, 3)
(4, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID) > 2 AND COUNT(DIRECTOR_ID) > 2;

/*
Prediction Result:
(1, 0)
(2, 3)
*/