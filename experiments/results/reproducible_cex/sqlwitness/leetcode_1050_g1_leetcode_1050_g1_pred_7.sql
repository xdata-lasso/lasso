-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, NULL, 4), (1, 4, 2), (0, 2, 4), (3, 0, NULL), (2, NULL, 3), (5, 1, 0), (6, 3, 0), (7, NULL, 1), (8, 1, 3), (9, NULL, 0), (10, 4, 3), (11, 1, 3), (12, 1, 1), (13, 0, 1), (14, NULL, 2), (15, 0, 4), (16, 4, 1), (17, NULL, 4), (18, NULL, 0), (19, 2, 2), (20, 4, NULL), (21, 3, NULL), (22, 0, 4), (23, 0, 4), (24, NULL, 0), (25, 1, NULL), (26, 0, 3), (27, 0, 0), (28, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 4)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY 1, 2 HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 0)
(0, 4)
*/