-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 2, NULL), (2, 2, 0), (4, 1, 1), (3, 3, 1), (1, NULL, NULL), (5, 3, 1), (6, NULL, 3), (7, 4, 0), (8, 3, 0), (9, 3, 1), (10, 4, 2), (11, NULL, NULL), (12, NULL, 2), (13, NULL, 4), (14, 2, 2), (15, 3, 4), (16, 3, 3), (17, 1, 0), (18, 2, 2), (19, NULL, 3), (20, 2, 4), (21, NULL, NULL), (22, 2, 1), (23, 3, 0), (24, 3, 0), (25, 0, 4), (26, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 0)
(3, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS NUM FROM ACTORDIRECTOR GROUP BY 1, 2) AS STATISTIC WHERE NUM >= 3;

/*
Prediction Result:
(None, None)
(3, 0)
(3, 1)
*/