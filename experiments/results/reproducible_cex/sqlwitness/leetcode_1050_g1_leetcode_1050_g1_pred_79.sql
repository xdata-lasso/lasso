-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 4, NULL), (0, 2, 0), (3, 2, 1), (4, 4, NULL), (2, 2, 2), (5, NULL, 2), (6, 0, 0), (7, 1, 1), (8, 3, NULL), (9, 1, 2), (10, 0, 2), (11, 4, 0), (12, 3, 2), (13, 3, 2), (14, 3, 1), (15, 4, 3), (16, 2, 1), (17, 2, 0), (18, 0, 2), (19, NULL, 0), (20, NULL, 3), (21, 4, 0), (22, NULL, 0), (23, 2, 4), (24, 0, 3), (25, 1, 4), (26, NULL, 0), (27, 2, 4), (28, 3, 0), (29, 2, 3), (30, 0, 1), (31, NULL, 3), (32, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS CNT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS AD WHERE CNT >= 3;

/*
Prediction Result:
(None, 0)
*/