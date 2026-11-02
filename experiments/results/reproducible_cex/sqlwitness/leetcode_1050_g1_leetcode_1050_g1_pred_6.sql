-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, NULL, NULL), (2, 3, 4), (3, 2, 4), (0, 1, NULL), (1, 2, 0), (5, 0, 1), (6, 2, 2), (7, 1, 3), (8, 1, 1), (9, NULL, 4), (10, 0, 0), (11, 1, 0), (12, NULL, 4), (13, 1, 4), (14, NULL, 1), (15, 2, 2), (16, 2, 1), (17, 1, 3), (18, 0, 2), (19, 1, NULL), (20, 0, NULL), (21, 2, NULL), (22, 2, 3), (23, 1, NULL), (24, 1, 1), (25, 0, 0), (26, NULL, 4), (27, 1, NULL), (28, 3, 1), (29, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
(0, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY 1, 2 HAVING COUNT(1) >= 3;

/*
Prediction Result:
(None, 4)
(0, 0)
(1, None)
*/