-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 3, 2), (4, NULL, 0), (1, NULL, 3), (0, NULL, 1), (3, NULL, 0), (5, 3, NULL), (6, 1, 3), (7, 3, 0), (8, 2, 2), (9, 1, 4), (10, NULL, 4), (11, 2, 1), (12, NULL, NULL), (13, 4, 2), (14, 3, NULL), (15, NULL, 0), (16, 2, 3), (17, 1, 3), (18, 2, 0), (19, 1, 1), (20, 1, NULL), (21, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS TOTAL_COUNT FROM ACTORDIRECTOR GROUP BY 1, 2) AS A WHERE TOTAL_COUNT >= 3;

/*
Prediction Result:
(None, 0)
*/