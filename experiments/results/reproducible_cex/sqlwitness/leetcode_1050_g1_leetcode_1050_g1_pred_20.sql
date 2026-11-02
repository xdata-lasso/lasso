-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (3, NULL, NULL), (2, 2, 0), (0, NULL, 3), (1, NULL, 3), (4, 0, 2), (5, 3, NULL), (6, 3, 0), (7, NULL, 2), (8, 0, 2), (9, 2, NULL), (10, 1, 2), (11, 2, 0), (12, 3, 2), (13, NULL, NULL), (14, NULL, 2), (15, NULL, 1), (16, 1, 1), (17, 1, 3), (18, NULL, NULL), (19, 3, 0), (20, NULL, 3), (21, 0, 1), (22, NULL, 1), (23, NULL, 2), (24, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) > 2 ORDER BY COUNT(TIMESTAMP) DESC, ACTOR_ID NULLS LAST, DIRECTOR_ID NULLS LAST;

/*
Prediction Result:
(None, 2)
(None, 3)
(None, None)
*/