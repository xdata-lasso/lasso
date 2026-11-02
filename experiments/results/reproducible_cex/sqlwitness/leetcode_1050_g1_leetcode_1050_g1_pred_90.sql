-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 4, 2), (4, 0, 2), (2, 1, 3), (3, NULL, 4), (0, 1, 3), (5, 4, 0), (6, 0, 1), (7, 1, 2), (8, 1, 1), (9, NULL, 4), (10, 4, 3), (11, 0, 1), (12, 1, 2), (13, 3, NULL), (14, 4, 4), (15, NULL, 4), (16, 0, 1), (17, 3, 2), (18, 3, 1), (19, 0, NULL), (20, 2, 4), (21, NULL, 0), (22, 1, NULL), (23, NULL, 1), (24, NULL, 1), (25, 1, 0), (26, 2, 2), (27, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(0, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(*) AS CNT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS TEMP WHERE CNT >= 3;

/*
Prediction Result:
(None, 4)
(0, 1)
*/