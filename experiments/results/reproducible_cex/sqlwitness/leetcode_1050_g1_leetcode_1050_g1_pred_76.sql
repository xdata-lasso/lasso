-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, NULL, 0), (0, 2, NULL), (2, 0, 2), (1, 2, NULL), (4, 2, NULL), (5, 1, NULL), (6, 1, 1), (7, 2, 2), (8, 2, 3), (9, 3, 2), (10, 2, 3), (11, NULL, 0), (12, 1, NULL), (13, 0, NULL), (14, 3, NULL), (15, 0, 0), (16, 0, 1), (17, NULL, 0), (18, 1, 0), (19, 1, 0), (20, 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS NUM FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS HIMAN WHERE NUM > 2;

/*
Prediction Result:
(None, 0)
(2, None)
*/