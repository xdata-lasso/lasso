-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: actordirector --
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483648, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483647, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483646, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (2, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (3, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483645, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483642, NULL, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483641, NULL, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483640, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(1) AS CNT, RANK() OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS RK FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(1) >= 3 ORDER BY COUNT(1) DESC, ACTOR_ID NULLS LAST, DIRECTOR_ID NULLS LAST, CNT NULLS LAST, RK NULLS LAST) SELECT ACTOR_ID, DIRECTOR_ID FROM CTE WHERE RK = 1;

/*
Prediction Result:
(1, 1)
(None, 1)
*/