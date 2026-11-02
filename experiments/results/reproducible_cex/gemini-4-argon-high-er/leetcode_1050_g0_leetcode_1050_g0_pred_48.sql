-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (1, NULL, 1);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (2, NULL, 1);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (3, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT DISTINCT X.ACTOR_ID, X.DIRECTOR_ID FROM ACTORDIRECTOR AS X INNER JOIN (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS FREQ FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS Y ON X.ACTOR_ID = Y.ACTOR_ID AND X.DIRECTOR_ID = Y.DIRECTOR_ID AND Y.FREQ >= 3;

/*
Prediction Result:
*/