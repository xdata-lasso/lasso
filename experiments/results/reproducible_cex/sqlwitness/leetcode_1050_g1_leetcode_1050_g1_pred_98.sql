-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, NULL, NULL), (3, NULL, 3), (0, 3, NULL), (2, NULL, 1), (4, 0, 2), (5, 1, 3), (6, 0, 3), (7, NULL, 2), (8, NULL, 1), (9, 0, 2), (10, NULL, 2), (11, 2, 0), (12, 2, 2), (13, 0, 0), (14, NULL, 1), (15, 3, NULL), (16, 2, 0), (17, 3, 2), (18, 0, 3), (19, 1, 3), (20, 0, 1), (21, 3, 2), (22, NULL, 1), (23, NULL, NULL), (24, 3, 3), (25, 2, 0), (26, 0, 3), (27, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, 0)
(0, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(2) > 2;

/*
Prediction Result:
(None, 1)
(0, 3)
(2, 0)
*/