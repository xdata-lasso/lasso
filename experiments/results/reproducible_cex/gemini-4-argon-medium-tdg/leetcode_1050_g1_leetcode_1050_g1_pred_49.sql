-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (1, NULL, 10);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (2, NULL, 10);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (3, NULL, 10);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (4, 20, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (5, 20, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (6, 20, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (7, NULL, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (8, NULL, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (9, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(20, None)
*/

-- Prediction Query
SELECT DISTINCT X.ACTOR_ID, X.DIRECTOR_ID FROM ACTORDIRECTOR AS X INNER JOIN (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS FREQ FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS Y ON X.ACTOR_ID = Y.ACTOR_ID AND X.DIRECTOR_ID = Y.DIRECTOR_ID AND Y.FREQ >= 3;

/*
Prediction Result:
*/