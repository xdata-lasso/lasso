-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, NULL, NULL), (2, 0, 0), (3, 0, 0), (0, 2, NULL), (4, 2, NULL), (5, 3, 2), (6, NULL, 3), (7, NULL, 1), (8, 1, 1), (9, 0, 0), (10, 1, 3), (11, 2, 3), (12, 2, 2), (13, 2, 0), (14, NULL, 1), (15, 0, NULL), (16, 0, NULL), (17, NULL, 1), (18, 2, NULL), (19, 3, NULL), (20, 2, NULL), (21, 3, NULL), (22, 2, 1), (23, 2, 3), (24, 1, 0), (25, 3, 3), (26, 3, 0), (27, 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
(0, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(*) > 2;

/*
Prediction Result:
(None, 1)
(0, 0)
(2, None)
*/