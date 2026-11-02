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
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID || DIRECTOR_ID) >= 3;

/*
Prediction Result:
(1009, 1010)
*/