-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (0, 2, 2), (3, 0, 2), (1, 2, NULL), (2, 2, 3), (4, 3, 0), (5, 2, NULL), (6, 2, 1), (7, 0, 1), (8, 0, 2), (9, 2, NULL), (10, NULL, 1), (11, 3, 1), (12, 1, NULL), (13, 0, NULL), (14, 3, 2), (15, 0, 2), (16, 2, 0), (17, 3, 1), (18, 2, 0), (19, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
(0, 2)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) > 2;

/*
Prediction Result:
(0, 2)
*/