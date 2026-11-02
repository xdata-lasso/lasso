-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 4, 1), (2, NULL, 0), (1, 2, 2), (4, 3, NULL), (0, 3, 4), (5, 4, 0), (6, 1, NULL), (7, 3, 3), (8, 3, 1), (9, 0, 1), (10, NULL, 1), (11, 2, 3), (12, 2, 0), (13, 1, NULL), (14, 2, 0), (15, 2, 1), (16, NULL, 3), (17, 2, 3), (18, NULL, 1), (19, NULL, 1), (20, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT A.ACTOR_ID, A.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS COOPERATION FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS A WHERE A.COOPERATION >= 3;

/*
Prediction Result:
(None, 1)
(1, None)
*/