-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (1, 1, NULL);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (2, 1, NULL);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (3, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
WITH CTE AS (SELECT SUB.*, COUNT(SUB.WORK_PAIR) OVER (PARTITION BY SUB.WORK_PAIR) AS COUNT_PAIR FROM (SELECT *, ACTOR_ID || ',' || DIRECTOR_ID AS WORK_PAIR FROM ACTORDIRECTOR) AS SUB) SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM CTE WHERE COUNT_PAIR > 2;

/*
Prediction Result:
*/