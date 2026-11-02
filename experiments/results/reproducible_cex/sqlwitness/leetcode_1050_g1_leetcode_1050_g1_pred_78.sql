-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 1, 2), (0, 0, 2), (1, 0, 4), (3, 4, 4), (2, NULL, 1), (5, 2, 3), (6, 0, 3), (7, NULL, 3), (8, 4, 4), (9, 1, 3), (10, 0, 2), (11, 1, NULL), (12, 4, 1), (13, 3, 3), (14, 2, NULL), (15, NULL, 2), (16, NULL, 2), (17, 3, 3), (18, 1, 2), (19, NULL, NULL), (20, 2, 1), (21, 2, 4), (22, 2, 2), (23, NULL, 0), (24, 0, 2), (25, NULL, NULL), (26, NULL, 1), (27, 2, 4), (28, NULL, 2), (29, 3, 0), (30, 3, 1), (31, 0, 0), (32, 3, 3), (33, 0, 4), (34, 1, NULL), (35, 2, 3), (36, 1, 0), (37, 1, 1), (38, 4, 3), (39, 0, 4), (40, 4, 1), (41, NULL, 4), (42, 1, 4), (43, 1, NULL), (44, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
(0, 2)
(3, 3)
(0, 4)
*/

-- Prediction Query
WITH TEMP AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS RN FROM ACTORDIRECTOR) SELECT ACTOR_ID, DIRECTOR_ID FROM TEMP WHERE RN >= 3 GROUP BY 1, 2;

/*
Prediction Result:
(None, 2)
(0, 2)
(0, 4)
(1, None)
(3, 3)
*/