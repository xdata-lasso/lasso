-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 0, 1), (0, 1, 1), (1, 3, NULL), (3, 3, NULL), (2, 2, 2), (5, 4, NULL), (6, 0, 1), (7, 4, 1), (8, NULL, 4), (9, 0, 3), (10, NULL, 4), (11, 0, 2), (12, 1, 1), (13, 2, 2), (14, 0, NULL), (15, NULL, 4), (16, 4, 1), (17, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 4)
(4, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) > 2 ORDER BY COUNT(TIMESTAMP) DESC, ACTOR_ID NULLS LAST, DIRECTOR_ID NULLS LAST;

/*
Prediction Result:
(4, 1)
(None, 4)
*/