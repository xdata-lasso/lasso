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

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483639, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483638, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483637, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483636, 1, NULL);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483635, 1, NULL);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483634, 1, NULL);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483633, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483632, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483631, 1, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483630, NULL, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483629, NULL, 1);

INSERT INTO "actordirector" ("timestamp", "actor_id", "director_id") VALUES (-2147483628, NULL, 1);
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
SELECT D1.ACTOR_ID, D1.DIRECTOR_ID FROM ACTORDIRECTOR AS D1 GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(DIRECTOR_ID) >= 3;

/*
Prediction Result:
(None, 1)
(1, 1)
*/