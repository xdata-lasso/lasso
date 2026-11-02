-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1018, 1021, 1022);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1019, 1021, 1022);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1020, 1021, 1022);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1023, NULL, 1027);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1024, NULL, 1027);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1025, NULL, 1027);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1021, 1022)
*/

-- Prediction Query
WITH CTE AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(1) AS CNT, RANK() OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID) AS RK FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(1) >= 3 ORDER BY COUNT(1) DESC, ACTOR_ID NULLS LAST, DIRECTOR_ID NULLS LAST, CNT NULLS LAST, RK NULLS LAST) SELECT ACTOR_ID, DIRECTOR_ID FROM CTE WHERE RK = 1;

/*
Prediction Result:
(1021, 1022)
(None, 1027)
*/