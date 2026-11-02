-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1006, 1009, 1010);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1007, 1009, 1010);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1008, 1009, 1010);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1011, NULL, 1015);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1012, NULL, 1015);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1013, NULL, 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 1015)
(1009, 1010)
*/

-- Prediction Query
SELECT DISTINCT A.ACTOR_ID, A.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(ACTOR_ID) OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP) AS RK FROM ACTORDIRECTOR) AS A WHERE A.RK >= 3;

/*
Prediction Result:
(1009, 1010)
*/