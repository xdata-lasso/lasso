-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1001, 1004, 1005);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1002, 1004, 1005);
INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (1003, 1004, 1005);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1004, 1005)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) >= '3';

/*
Prediction Result:
*/