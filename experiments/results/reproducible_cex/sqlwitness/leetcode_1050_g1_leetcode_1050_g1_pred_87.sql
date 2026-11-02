-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 1, 2), (1, 0, 0), (4, 4, 2), (0, 4, 0), (2, 2, 3), (5, 4, 1), (6, 0, 3), (7, NULL, 0), (8, 4, 2), (9, NULL, 3), (10, 4, 1), (11, 4, 1), (12, 3, 2), (13, 2, NULL), (14, NULL, NULL), (15, 1, 2), (16, 2, 1), (17, NULL, 4), (18, 1, 1), (19, NULL, 1), (20, 2, 0), (21, NULL, 1), (22, 0, 1), (23, NULL, 0), (24, NULL, 4), (25, NULL, 0), (26, 4, NULL), (27, 1, 0), (28, 1, 2), (29, 3, 3), (30, 4, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 1)
(1, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT COUNT(*) AS ACTORDIRECTORCOUNT, ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS ACTORDIRECTORCOUNT WHERE ACTORDIRECTORCOUNT >= 3;

/*
Prediction Result:
(None, 0)
(1, 2)
(4, 1)
*/