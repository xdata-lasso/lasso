-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 3, 0), (2, 4, 1), (0, 2, 0), (1, 1, NULL), (4, 1, 1), (5, 1, NULL), (6, 3, 0), (7, 0, 0), (8, NULL, 0), (9, 1, NULL), (10, 0, 2), (11, 4, 0), (12, 0, 2), (13, 4, NULL), (14, 4, 3), (15, 1, 0), (16, 1, 4), (17, 1, 4), (18, 4, 4), (19, 4, 3), (20, 1, 3), (21, 0, 4), (22, 2, 0), (23, 2, 1), (24, 2, 0), (25, 0, 4), (26, 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
(2, 0)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
(2, 0)
*/