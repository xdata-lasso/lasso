-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO actordirector (timestamp, actor_id, director_id) VALUES (1, 2, NULL), (4, 3, 1), (2, 4, NULL), (0, 2, NULL), (3, 2, NULL), (5, 4, 2), (6, NULL, 3), (7, NULL, 1), (8, 4, 0), (9, 2, 0), (10, 1, 3), (11, 0, 1), (12, 2, 2), (13, 4, 0), (14, 2, 3), (15, 4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
WITH TT AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(DIRECTOR_ID) AS COLLAB FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) SELECT ACTOR_ID, DIRECTOR_ID FROM TT WHERE COLLAB >= 3;

/*
Prediction Result:
*/