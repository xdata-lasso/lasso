-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 2, 0), (3, NULL, 3), (0, 2, 0), (2, 3, 3), (1, 0, NULL), (5, NULL, 4), (6, 1, NULL), (7, NULL, 1), (8, 1, NULL), (9, 4, 3), (10, 0, 3), (11, 2, 3), (12, 0, NULL), (13, NULL, 0), (14, NULL, 4), (15, 1, 0), (16, 3, 3), (17, 1, NULL), (18, NULL, 4), (19, NULL, 4), (20, 0, 4), (21, NULL, 1), (22, 4, NULL), (23, 4, 0), (24, 0, 1), (25, 3, NULL), (26, 0, 3), (27, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT DISTINCT A.ACTOR_ID, A.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, RANK() OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP) AS RK FROM ACTORDIRECTOR) AS A WHERE A.RK >= 3;

/*
Prediction Result:
(None, 4)
(1, None)
*/