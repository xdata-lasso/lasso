-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (1, NULL, 100);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (2, NULL, 100);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (3, NULL, 100);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (4, 200, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (5, 200, NULL);
INSERT INTO ActorDirector (timestamp, actor_id, director_id) VALUES (6, 200, NULL);
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
(None, 100)
(200, None)
*/

-- Prediction Query
WITH CTE AS (SELECT CASE WHEN (LEAD(DIRECTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP) = LAG(DIRECTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP)) AND (LEAD(ACTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP) = LAG(ACTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP)) THEN DIRECTOR_ID END AS DIRECTOR_ID, CASE WHEN (LEAD(DIRECTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP)) = (LAG(DIRECTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP)) AND (LEAD(ACTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP)) = (LAG(ACTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP)) THEN ACTOR_ID END AS ACTOR_ID FROM ACTORDIRECTOR) SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM CTE WHERE NOT ACTOR_ID IS NULL AND NOT DIRECTOR_ID IS NULL;

/*
Prediction Result:
*/