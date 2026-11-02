-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 2, NULL), (1, NULL, NULL), (3, 1, 3), (2, 1, 0), (4, 1, 1), (5, 2, 2), (6, NULL, 2), (7, 3, NULL), (8, 2, NULL), (9, 3, 2), (10, NULL, 2), (11, 1, 2), (12, NULL, 2), (13, 2, NULL), (14, 0, NULL), (15, 2, 3), (16, 0, 1), (17, 2, 0), (18, 0, 0), (19, 0, 1), (20, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY 1, 2 HAVING COUNT(TIMESTAMP) > 2;

/*
Prediction Result:
(None, 2)
(2, None)
*/