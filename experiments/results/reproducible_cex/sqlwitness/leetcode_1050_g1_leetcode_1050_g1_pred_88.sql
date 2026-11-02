-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 0, 0), (2, 3, 2), (1, 0, 4), (0, 2, 4), (4, NULL, 0), (5, 3, 1), (6, 4, 4), (7, 2, 3), (8, 3, NULL), (9, 3, 1), (10, 0, 2), (11, NULL, 0), (12, 3, 4), (13, 4, 1), (14, 4, 3), (15, 0, NULL), (16, 4, 2), (17, 3, 3), (18, 2, 4), (19, 1, 4), (20, 1, NULL), (21, 3, NULL), (22, NULL, 0), (23, 4, 0), (24, 3, NULL), (25, 0, 2), (26, 4, 3), (27, 0, 0), (28, 3, 3), (29, 2, 1), (30, 2, 3), (31, NULL, 2), (32, 3, 0), (33, NULL, 4), (34, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, None)
*/

-- Prediction Query
WITH A AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS CT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) SELECT ACTOR_ID, DIRECTOR_ID FROM A WHERE CT >= 3;

/*
Prediction Result:
(None, 0)
(3, None)
*/