-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, NULL, 4), (3, 0, 2), (1, 2, 0), (0, 2, 0), (2, NULL, NULL), (5, 4, 4), (6, 4, 2), (7, 0, 4), (8, NULL, 4), (9, 3, 3), (10, 3, 0), (11, NULL, 2), (12, 4, 2), (13, 1, 1), (14, 4, 3), (15, NULL, 2), (16, NULL, 4), (17, NULL, 1), (18, 0, 3), (19, NULL, 2), (20, 0, 4), (21, 1, 2), (22, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 2)
(None, 4)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID) AS CNT FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID) AS INN WHERE CNT > 2;

/*
Prediction Result:
*/