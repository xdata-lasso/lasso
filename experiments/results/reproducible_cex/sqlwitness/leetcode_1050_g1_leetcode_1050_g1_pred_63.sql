-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 2, 0), (2, 3, 3), (3, 2, 0), (1, 2, 0), (4, 3, 1), (5, 1, NULL), (6, 1, 2), (7, 3, NULL), (8, 1, 3), (9, 2, 0), (10, 2, 3), (11, 1, 2), (12, 0, 2), (13, NULL, 1), (14, NULL, 2), (15, 1, 3), (16, 2, 3), (17, NULL, 3), (18, 2, 0), (19, 1, 2), (20, 1, NULL), (21, 1, NULL), (22, 2, 2), (23, 2, 2), (24, 1, 0), (25, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
(2, 0)
(1, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID) > 2 AND COUNT(DIRECTOR_ID) > 2;

/*
Prediction Result:
(1, 2)
(2, 0)
*/