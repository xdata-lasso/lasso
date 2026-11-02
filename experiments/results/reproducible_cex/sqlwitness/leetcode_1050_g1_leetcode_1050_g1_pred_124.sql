-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, NULL, 3), (2, NULL, 4), (4, NULL, 0), (0, 1, NULL), (1, 3, NULL), (5, 3, 1), (6, 4, 0), (7, 3, 0), (8, 1, 0), (9, 1, NULL), (10, 4, NULL), (11, 4, 1), (12, 0, 4), (13, 4, 2), (14, 0, NULL), (15, 1, NULL), (16, 2, 3), (17, NULL, 2), (18, 2, 0), (19, 2, 0), (20, 3, NULL), (21, 1, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR WHERE (ACTOR_ID, DIRECTOR_ID) IN (SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY 1, 2 HAVING COUNT(*) >= 3);

/*
Prediction Result:
*/