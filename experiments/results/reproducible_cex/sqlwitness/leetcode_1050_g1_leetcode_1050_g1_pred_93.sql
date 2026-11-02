-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, NULL, 3), (1, 4, 3), (4, 3, 1), (3, 0, 0), (2, NULL, NULL), (5, 1, 3), (6, 3, 0), (7, NULL, 3), (8, NULL, NULL), (9, 4, 0), (10, 3, 0), (11, NULL, 4), (12, 4, 4), (13, 4, 2), (14, 4, 3), (15, 3, 4), (16, 0, 3), (17, 4, 1), (18, 4, 4), (19, 4, 3), (20, 2, 4), (21, 4, NULL), (22, 3, 1), (23, 1, 2), (24, 2, 1), (25, 4, 2), (26, 4, 4), (27, NULL, 0), (28, 3, 2), (29, 2, 0), (30, 1, 1), (31, NULL, 3), (32, 4, 3), (33, NULL, 4), (34, NULL, 1), (35, 4, 4), (36, NULL, 1), (37, 2, 1), (38, 2, 2), (39, 3, NULL), (40, 4, NULL), (41, 2, 4), (42, 0, 1), (43, 4, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, 3)
(4, 4)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR AS AD GROUP BY 1, 2 HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 3)
(4, 3)
(4, 4)
*/