-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 0, 2), (0, NULL, 4), (1, 4, NULL), (4, 4, 1), (3, 2, 3), (5, 1, 0), (6, 4, 4), (7, 1, 1), (8, 1, 2), (9, 4, NULL), (10, NULL, 4), (11, 3, 4), (12, 0, 3), (13, 2, 1), (14, 1, 1), (15, 4, 2), (16, NULL, 0), (17, 3, 0), (18, 4, NULL), (19, 2, 3), (20, 0, 0), (21, 0, 4), (22, 4, NULL), (23, 2, 2), (24, 3, 4), (25, NULL, 3), (26, 2, 1), (27, 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(4, None)
*/

-- Prediction Query
SELECT DISTINCT X.ACTOR_ID, X.DIRECTOR_ID FROM ACTORDIRECTOR AS X INNER JOIN (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS FREQ FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS Y ON X.ACTOR_ID = Y.ACTOR_ID AND X.DIRECTOR_ID = Y.DIRECTOR_ID AND Y.FREQ >= 3;

/*
Prediction Result:
*/