-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 4, NULL), (4, 2, 0), (0, 4, 4), (2, NULL, NULL), (3, 2, NULL), (5, NULL, NULL), (6, NULL, NULL), (7, 0, 3), (8, 2, 1), (9, 4, NULL), (10, 2, 2), (11, 2, 1), (12, 3, 0), (13, 2, 3), (14, NULL, 0), (15, 3, 2), (16, 2, NULL), (17, NULL, 2), (18, 2, NULL), (19, 2, 4), (20, 4, 2), (21, 0, 2), (22, NULL, NULL), (23, 0, 0), (24, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS COOPERATED_FRQ FROM ACTORDIRECTOR GROUP BY 1, 2) AS A WHERE A.COOPERATED_FRQ >= 3;

/*
Prediction Result:
(None, None)
(2, None)
*/