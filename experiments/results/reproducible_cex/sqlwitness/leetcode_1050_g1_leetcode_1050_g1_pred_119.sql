-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 2, NULL), (3, 2, 1), (0, 3, 3), (2, 2, 2), (4, 2, 1), (5, 0, 4), (6, NULL, 1), (7, 3, 2), (8, 2, 0), (9, 0, NULL), (10, 0, 2), (11, NULL, 1), (12, NULL, 0), (13, NULL, 3), (14, NULL, 1), (15, NULL, 1), (16, 2, 3), (17, 1, 3), (18, 2, 3), (19, NULL, 2), (20, 4, 3), (21, NULL, 4), (22, 0, NULL), (23, 4, 2), (24, 0, 4), (25, 2, 2), (26, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
WITH RAW AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS TIMES FROM ACTORDIRECTOR GROUP BY 1, 2 HAVING COUNT(TIMESTAMP) >= 3) SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM RAW;

/*
Prediction Result:
(None, 1)
*/