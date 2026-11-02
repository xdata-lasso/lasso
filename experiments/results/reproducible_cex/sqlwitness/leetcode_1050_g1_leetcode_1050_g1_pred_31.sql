-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (2, 2, 0), (0, 0, 1), (1, NULL, 2), (4, 4, NULL), (3, 4, 0), (5, 0, 1), (6, 4, 0), (7, NULL, 2), (8, 1, 3), (9, 3, 3), (10, 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, ACTOR_ID || '-' || DIRECTOR_ID AS PAIR, COUNT(*) AS CT FROM ACTORDIRECTOR GROUP BY PAIR) AS P WHERE CT >= 3;

/*
Prediction Result:
(None, 2)
*/