-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 2, 0), (4, 1, NULL), (0, 3, 0), (3, 4, 3), (1, 2, 3), (5, 1, NULL), (6, 2, 3), (7, 3, NULL), (8, 3, NULL), (9, 1, NULL), (10, 0, 0), (11, 3, 1), (12, 3, 3), (13, 4, 1), (14, 3, 0), (15, 3, NULL), (16, 0, NULL), (17, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(1, None)
(3, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, TIMESTAMP FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3) AS A;

/*
Prediction Result:
*/