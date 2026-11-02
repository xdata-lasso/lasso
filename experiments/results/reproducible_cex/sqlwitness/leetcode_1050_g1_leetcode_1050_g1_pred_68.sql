-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 1, 2), (1, 4, NULL), (3, NULL, 1), (0, NULL, NULL), (2, 1, 3), (5, 2, NULL), (6, 0, 4), (7, 3, 0), (8, 3, 0), (9, 3, 1), (10, 3, 1), (11, NULL, 0), (12, NULL, 4), (13, 3, 1), (14, 2, 1), (15, 1, 2), (16, NULL, NULL), (17, NULL, NULL), (18, 4, 3), (19, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 1)
*/

-- Prediction Query
SELECT SUB.A_ID AS ACTOR_ID, SUB.D_ID AS DIRECTOR_ID FROM (SELECT ACTOR_ID AS A_ID, DIRECTOR_ID AS D_ID, COUNT(TIMESTAMP) AS C FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS SUB WHERE SUB.C >= 3;

/*
Prediction Result:
(None, None)
(3, 1)
*/