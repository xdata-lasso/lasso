-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (4, 1, 4), (3, 2, 0), (2, NULL, 3), (1, 0, 3), (0, 3, 3), (5, 3, 3), (6, NULL, NULL), (7, NULL, 2), (8, NULL, 3), (9, 1, 1), (10, NULL, NULL), (11, NULL, NULL), (12, 0, NULL), (13, NULL, 3), (14, 0, 1), (15, 3, 4), (16, 3, 2), (17, 3, NULL), (18, 4, 0), (19, 0, 0), (20, 1, NULL), (21, 4, NULL), (22, 2, 0), (23, 4, 3), (24, 3, 3), (25, NULL, NULL), (26, 4, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(3, 3)
*/

-- Prediction Query
SELECT A.ACTOR_ID, A.DIRECTOR_ID FROM ACTORDIRECTOR AS A GROUP BY A.ACTOR_ID, A.DIRECTOR_ID HAVING COUNT(A.TIMESTAMP) >= 3;

/*
Prediction Result:
(None, None)
(None, 3)
(3, 3)
*/