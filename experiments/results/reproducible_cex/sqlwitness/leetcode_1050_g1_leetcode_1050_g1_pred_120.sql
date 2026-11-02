-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 3, 3), (0, 0, 2), (4, 1, NULL), (2, 3, NULL), (1, 0, 4), (5, 1, 1), (6, 2, 2), (7, 2, 0), (8, 1, NULL), (9, NULL, NULL), (10, 4, 3), (11, 1, 1), (12, 1, 0), (13, NULL, 1), (14, 1, NULL), (15, NULL, NULL), (16, 4, 1), (17, 4, 2), (18, 4, 3), (19, 4, NULL), (20, 1, 3), (21, 2, 0), (22, 0, NULL), (23, NULL, NULL), (24, 4, NULL), (25, 0, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, ROW_NUMBER() OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP) AS RW FROM ACTORDIRECTOR) AS D WHERE RW >= 3 GROUP BY 1, 2;

/*
Prediction Result:
(None, None)
(1, None)
*/