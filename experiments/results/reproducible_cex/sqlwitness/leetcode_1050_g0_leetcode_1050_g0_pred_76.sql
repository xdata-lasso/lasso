-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 0, 3), (2, 1, 2), (3, 1, NULL), (1, 0, NULL), (0, 0, NULL), (5, 0, 0), (6, 0, NULL), (7, NULL, 3), (8, NULL, NULL), (9, 4, 0), (10, 2, 1), (11, 2, NULL), (12, 0, 4), (13, 3, 4), (14, 3, NULL), (15, 3, 2), (16, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
WITH TT AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(DIRECTOR_ID) AS COLLAB FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) SELECT ACTOR_ID, DIRECTOR_ID FROM TT WHERE COLLAB >= 3;

/*
Prediction Result:
*/