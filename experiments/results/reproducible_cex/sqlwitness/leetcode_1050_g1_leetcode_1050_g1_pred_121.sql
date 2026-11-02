-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, NULL, 2), (0, NULL, NULL), (3, 3, 0), (1, 2, 1), (4, 0, 1), (5, 0, NULL), (6, 2, 1), (7, 3, 2), (8, 3, 1), (9, 3, 3), (10, 2, 2), (11, 2, 1), (12, 3, NULL), (13, 3, 3), (14, 0, NULL), (15, NULL, 2), (16, 1, 0), (17, NULL, NULL), (18, 1, 3), (19, 3, 3), (20, 1, 3), (21, 1, 3), (22, NULL, NULL), (23, 1, 3), (24, 3, 0), (25, 2, 0), (26, 2, 2), (27, 2, 2), (28, NULL, 1), (29, NULL, NULL), (30, 3, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, 1)
(2, 2)
(1, 3)
(3, 3)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT DISTINCT ACTOR_ID, DIRECTOR_ID, COUNT(*) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS CNT FROM ACTORDIRECTOR) AS A WHERE CNT > 2;

/*
Prediction Result:
(None, None)
(1, 3)
(2, 1)
(2, 2)
(3, 3)
*/