-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 3, 3), (1, 0, 4), (0, 3, NULL), (4, 0, NULL), (2, 4, 0), (5, 1, 3), (6, NULL, NULL), (7, 0, 3), (8, NULL, NULL), (9, 3, 4), (10, 2, 0), (11, 0, 4), (12, 2, 3), (13, NULL, 2), (14, 2, 1), (15, 4, 2), (16, 4, NULL), (17, 3, 2), (18, 0, NULL), (19, 2, 3), (20, 3, 4), (21, 1, 0), (22, NULL, NULL), (23, 0, NULL), (24, 4, 1), (25, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS AD FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS AD WHERE AD >= 3;

/*
Prediction Result:
(None, None)
(0, None)
*/