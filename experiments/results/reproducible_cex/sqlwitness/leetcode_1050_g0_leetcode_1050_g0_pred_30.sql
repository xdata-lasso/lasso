-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, NULL, 0), (0, 4, 0), (2, NULL, 3), (3, 1, NULL), (1, NULL, 2), (5, 4, 3), (6, 3, 0), (7, 2, 0), (8, 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, ACTOR_ID || '-' || DIRECTOR_ID AS PAIR, COUNT(*) AS CT FROM ACTORDIRECTOR GROUP BY PAIR) AS P WHERE CT >= 3;

/*
Prediction Result:
(None, 2)
*/