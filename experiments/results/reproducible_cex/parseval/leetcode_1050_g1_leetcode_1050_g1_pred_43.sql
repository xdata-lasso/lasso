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
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT('TIMESTAMP') >= 3;

/*
Prediction Result:
(None, 1)
(1, 1)
*/