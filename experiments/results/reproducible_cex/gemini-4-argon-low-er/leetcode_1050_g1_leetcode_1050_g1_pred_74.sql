-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (1, NULL, 10);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (2, NULL, 10);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (3, NULL, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT AD.ACTOR_ID, AD.DIRECTOR_ID FROM ACTORDIRECTOR AS AD GROUP BY AD.ACTOR_ID, AD.DIRECTOR_ID HAVING COUNT(AD.TIMESTAMP) >= 3;

/*
Prediction Result:
(None, 10)
*/