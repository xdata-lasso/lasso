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

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483642, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483641, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483640, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483639, NULL, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483638, NULL, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483637, NULL, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483636, 1, NULL);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483635, 1, NULL);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483634, 1, NULL);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483633, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483632, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483631, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483630, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483629, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483628, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 1)
(1, None)
(1, 1)
*/

-- Prediction Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(ACTOR_ID) >= 3 AND COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
(1, 1)
*/