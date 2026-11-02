-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (1, NULL, 1);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (2, NULL, 1);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (3, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(1) AS CNT, RANK() OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS RK FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(1) >= 3 ORDER BY COUNT(1) DESC, ACTOR_ID NULLS LAST, DIRECTOR_ID NULLS LAST, CNT NULLS LAST, RK NULLS LAST) SELECT ACTOR_ID, DIRECTOR_ID FROM CTE WHERE RK = 1;

/*
Prediction Result:
(None, 1)
*/