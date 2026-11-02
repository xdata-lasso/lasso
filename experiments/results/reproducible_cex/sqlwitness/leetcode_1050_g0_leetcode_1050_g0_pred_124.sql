-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, NULL, 4), (2, 2, 2), (4, 4, 0), (1, 1, 2), (3, 3, 3), (5, 3, 3), (6, 2, NULL), (7, 0, 2), (8, 2, NULL), (9, 1, 4), (10, 2, NULL), (11, 0, 2), (12, 0, 1), (13, NULL, 3), (14, 2, 1), (15, 2, 1), (16, NULL, 2), (17, 4, 3), (18, 0, NULL), (19, 0, 1), (20, 0, 3), (21, 1, 3), (22, 2, 2), (23, 1, 0), (24, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(0, 2)
(2, None)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR WHERE (ACTOR_ID, DIRECTOR_ID) IN (SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY 1, 2 HAVING COUNT(*) >= 3);

/*
Prediction Result:
(0, 2)
*/