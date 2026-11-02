-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 1, 0), (2, 0, 0), (1, 4, 3), (3, NULL, 1), (4, 0, NULL), (5, 0, 1), (6, 4, 0), (7, NULL, NULL), (8, 4, 1), (9, 1, 4), (10, 1, 4), (11, 1, NULL), (12, 0, 4), (13, NULL, 3), (14, 2, 1), (15, 2, 0), (16, 0, 2), (17, 4, 0), (18, 4, 0), (19, 3, 2), (20, 1, 1), (21, 0, 4), (22, 3, 0), (23, 4, 1), (24, 2, NULL), (25, 2, 2), (26, 1, 2), (27, NULL, NULL), (28, NULL, NULL), (29, NULL, NULL), (30, 1, 3), (31, 0, 1), (32, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 0)
*/

-- Prediction Query
SELECT SUB.ACTOR_ID, SUB.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS COPERATED_COUNT FROM ACTORDIRECTOR GROUP BY 1, 2) AS SUB WHERE COPERATED_COUNT >= 3;

/*
Prediction Result:
(None, None)
(4, 0)
*/