-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests NULL handling in GROUP BY and COUNT(*) vs COUNT(actor_id) / COUNT(director_id).
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
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, None)
(None, 10)
(20, None)
*/

-- Prediction Query
WITH COUNT_TABLE AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID) AS CT FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) SELECT ACTOR_ID, DIRECTOR_ID FROM COUNT_TABLE WHERE CT >= 3;

/*
Prediction Result:
(20, None)
*/