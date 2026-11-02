-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 2, 2), (0, 4, 4), (2, 4, 2), (1, NULL, 0), (4, 4, 4), (5, 2, 4), (6, 1, 1), (7, 4, 0), (8, 0, 3), (9, 2, 1), (10, 0, 0), (11, 3, NULL), (12, 4, 4), (13, 0, 1), (14, 0, NULL), (15, NULL, 3), (16, 4, 4), (17, 2, NULL), (18, 1, 2), (19, NULL, 3), (20, NULL, 3), (21, 3, 2), (22, 2, 0), (23, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 3)
(4, 4)
*/

-- Prediction Query
SELECT DISTINCT X.ACTOR_ID, X.DIRECTOR_ID FROM ACTORDIRECTOR AS X INNER JOIN (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS FREQ FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS Y ON X.ACTOR_ID = Y.ACTOR_ID AND X.DIRECTOR_ID = Y.DIRECTOR_ID AND Y.FREQ >= 3;

/*
Prediction Result:
(4, 4)
*/