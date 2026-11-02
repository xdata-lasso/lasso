-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 3, 3), (2, 1, 4), (3, 0, 4), (1, NULL, 3), (0, NULL, 3), (5, 4, 4), (6, NULL, 3), (7, 2, 2), (8, 0, NULL), (9, 1, 0), (10, 0, 2), (11, 2, 4), (12, 4, 0), (13, 1, 2), (14, 0, 0), (15, 1, 0), (16, 4, 2), (17, 2, 3), (18, 3, 0), (19, 4, 2), (20, 2, NULL), (21, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT A1.ACTOR_ID, A1.DIRECTOR_ID FROM ACTORDIRECTOR AS A1 GROUP BY A1.ACTOR_ID, A1.DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 3)
*/