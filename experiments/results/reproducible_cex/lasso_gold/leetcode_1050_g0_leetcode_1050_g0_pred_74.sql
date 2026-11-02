-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1006, 1009, 1010);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1007, 1009, 1010);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1008, 1009, 1010);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1019, 1022, NULL);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1020, 1022, NULL);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1021, 1022, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(1009, 1010)
(1022, None)
*/

-- Prediction Query
SELECT D1.ACTOR_ID, D1.DIRECTOR_ID FROM ACTORDIRECTOR AS D1 GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
(1009, 1010)
*/