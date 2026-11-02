-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 0, 4), (2, 3, 1), (1, 1, 0), (0, 3, 4), (4, 4, 3), (5, 0, 4), (6, 0, 2), (7, NULL, 0), (8, NULL, 2), (9, 2, 4), (10, 1, 2), (11, 1, 4), (12, 4, 4), (13, NULL, 1), (14, 2, NULL), (15, 0, 3), (16, NULL, 0), (17, 0, 0), (18, 4, 0), (19, 2, 1), (20, NULL, 4), (21, 4, 4), (22, NULL, NULL), (23, NULL, NULL), (24, 3, 4), (25, 4, 2), (26, NULL, 2), (27, 1, 4), (28, 4, 1), (29, 2, 0), (30, NULL, 1), (31, 2, NULL), (32, 2, 4), (33, 3, 2), (34, 1, NULL), (35, 0, 2), (36, 0, 1), (37, 4, 1), (38, 4, 0), (39, 3, 3), (40, 3, 4), (41, NULL, 3), (42, 3, 4), (43, 4, 2), (44, 3, NULL), (45, NULL, 1), (46, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 4)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY 1, 2 HAVING COUNT(TIMESTAMP) >= 3;

/*
Prediction Result:
(None, 1)
(3, 4)
*/