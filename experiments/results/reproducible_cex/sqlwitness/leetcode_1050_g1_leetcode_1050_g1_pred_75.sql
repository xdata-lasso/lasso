-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 2, 4), (2, 0, NULL), (0, 0, 3), (3, 4, 2), (4, 4, 3), (5, 2, 1), (6, 0, 1), (7, 2, NULL), (8, 3, 4), (9, 2, NULL), (10, NULL, 2), (11, 4, NULL), (12, 0, 0), (13, 2, 2), (14, NULL, 2), (15, 1, 3), (16, 0, 3), (17, 3, 2), (18, 0, 3), (19, 0, 4), (20, 4, 2), (21, 4, NULL), (22, 4, 0), (23, 4, 3), (24, NULL, 2), (25, 0, 0), (26, 4, 0), (27, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 0)
(0, 3)
*/

-- Prediction Query
SELECT D1.ACTOR_ID, D1.DIRECTOR_ID FROM ACTORDIRECTOR AS D1 GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
(None, 2)
(0, 0)
(0, 3)
*/