-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1025, 1028, 1029);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1026, 1028, 1029);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1027, 1028, 1029);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1038, 1041, NULL);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1039, 1041, NULL);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1040, 1041, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1041, None)
(1028, 1029)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID + DIRECTOR_ID) >= 3;

/*
Prediction Result:
(1028, 1029)
*/