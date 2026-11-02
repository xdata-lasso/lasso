-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 0, 1), (1, 2, 1), (3, 2, 4), (4, 0, 3), (2, 3, 2), (5, NULL, 3), (6, 2, 1), (7, 4, 3), (8, 4, 1), (9, NULL, NULL), (10, 2, NULL), (11, 0, 3), (12, NULL, 2), (13, 3, 2), (14, 1, 0), (15, NULL, 4), (16, NULL, NULL), (17, NULL, 2), (18, 2, 2), (19, 3, 4), (20, 2, 1), (21, NULL, 2), (22, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY 1, 2 HAVING COUNT(DISTINCT TIMESTAMP) >= 3;

/*
Prediction Result:
(None, None)
(None, 2)
(2, 1)
*/