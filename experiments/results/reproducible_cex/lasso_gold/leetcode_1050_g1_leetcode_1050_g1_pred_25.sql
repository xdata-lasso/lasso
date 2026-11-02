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
SELECT T1.ACTOR_ID, T1.DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS TIMES_COOPERATED FROM ACTORDIRECTOR GROUP BY 1, 2) AS T1 WHERE T1.TIMES_COOPERATED >= 3;

/*
Prediction Result:
(None, 1027)
(1021, 1022)
*/