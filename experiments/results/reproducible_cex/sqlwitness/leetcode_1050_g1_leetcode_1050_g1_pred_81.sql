-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 1, 0), (4, 3, NULL), (2, 0, 3), (0, 4, NULL), (3, NULL, 2), (5, 0, 0), (6, 1, NULL), (7, 3, 4), (8, 2, NULL), (9, 2, 0), (10, 4, 2), (11, 3, 3), (12, 2, 1), (13, 3, 2), (14, NULL, 0), (15, 0, 4), (16, 0, 0), (17, 4, NULL), (18, 3, 0), (19, NULL, 0), (20, 1, 2), (21, 3, 2), (22, 2, NULL), (23, 4, 2), (24, 4, 3), (25, 4, 1), (26, NULL, 0), (27, NULL, 1), (28, 2, 3), (29, 3, NULL), (30, 1, 3), (31, 2, 3), (32, NULL, 2), (33, 0, 2), (34, 0, 1), (35, 0, 4), (36, 2, 1), (37, 3, 3), (38, 3, NULL), (39, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS NUM FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS NEW WHERE NEW.NUM >= 3;

/*
Prediction Result:
(None, 0)
(3, None)
*/