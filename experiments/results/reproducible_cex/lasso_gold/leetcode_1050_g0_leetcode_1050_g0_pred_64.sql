-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1067, NULL, 1068);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1069, 1070, NULL);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1071, NULL, 1072);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID || '*' || DIRECTOR_ID HAVING COUNT(*) >= 3;

/*
Prediction Result:
(None, 1068)
*/