-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 1, 2), (0, 4, 4), (4, 3, NULL), (2, 0, 2), (3, NULL, 1), (5, 4, 1), (6, 4, 1), (7, 2, 3), (8, NULL, 1), (9, 0, 4), (10, 2, 4), (11, 1, 3), (12, NULL, 2), (13, 0, 1), (14, 4, NULL), (15, NULL, 1), (16, 3, 1), (17, 2, 3), (18, 1, 2), (19, 3, 2), (20, NULL, 2), (21, 3, 4), (22, 0, 3), (23, 1, 0), (24, NULL, 0), (25, 4, 2), (26, 2, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
WITH COUNT_TABLE AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID) AS CT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) SELECT ACTOR_ID, DIRECTOR_ID FROM COUNT_TABLE WHERE CT >= 3;

/*
Prediction Result:
*/