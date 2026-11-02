-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 3, 3), (0, 1, 3), (2, 2, 0), (3, 0, NULL), (4, 1, 3), (5, 2, NULL), (6, NULL, 2), (7, 1, 1), (8, NULL, 1), (9, NULL, 1), (10, 0, NULL), (11, 3, 0), (12, NULL, NULL), (13, 3, 1), (14, 0, 0), (15, NULL, 0), (16, 1, 0), (17, 0, 2), (18, NULL, NULL), (19, 2, 3), (20, 2, 0), (21, 0, NULL), (22, 2, 3), (23, 2, 3), (24, 3, 1), (25, 0, 1), (26, 3, 0), (27, 0, 0), (28, 2, 3), (29, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, None)
(2, 3)
*/

-- Prediction Query
SELECT ACTOR_ID AS ACTOR_ID, DIRECTOR_ID AS DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(1) > 2;

/*
Prediction Result:
(None, 1)
(0, None)
(2, 3)
*/