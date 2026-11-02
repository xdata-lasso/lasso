-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 4, 2), (0, 1, 0), (1, 0, 3), (3, NULL, 2), (2, NULL, 4), (5, NULL, 4), (6, 4, 3), (7, 2, 0), (8, 2, NULL), (9, 4, 3), (10, 4, NULL), (11, 1, 4), (12, 2, 4), (13, 2, NULL), (14, 4, NULL), (15, 4, 3), (16, 3, 0), (17, 2, 4), (18, 1, 2), (19, NULL, 3), (20, 1, 1), (21, 0, 4), (22, 0, 2), (23, NULL, 0), (24, 4, 0), (25, 2, 1), (26, NULL, 2), (27, 3, 4), (28, NULL, 0), (29, NULL, 4), (30, 4, 1), (31, 4, 4), (32, 1, 1), (33, 3, NULL), (34, 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS TIMES FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING TIMES >= 3) AS SUB;

/*
Prediction Result:
(None, 4)
(4, 3)
*/