-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, 3, NULL), (4, 0, NULL), (1, 4, NULL), (0, 4, 1), (2, 2, NULL), (5, 3, 3), (6, 4, 3), (7, 1, 0), (8, 2, 4), (9, 3, 3), (10, NULL, 2), (11, 1, NULL), (12, 3, 3), (13, NULL, NULL), (14, 2, NULL), (15, NULL, 3), (16, 1, 3), (17, NULL, 2), (18, 2, 3), (19, 1, 3), (20, 3, 3), (21, NULL, 3), (22, 3, 1), (23, 4, 0), (24, 0, 0), (25, NULL, 2), (26, 0, 0), (27, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 3)
*/

-- Prediction Query
WITH TEMP AS (SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) >= 3) SELECT * FROM TEMP;

/*
Prediction Result:
(None, 2)
(3, 3)
*/