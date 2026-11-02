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
SELECT DISTINCT X.ACTOR_ID, X.DIRECTOR_ID FROM ACTORDIRECTOR AS X INNER JOIN (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(TIMESTAMP) AS FREQ FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID) AS Y ON X.ACTOR_ID = Y.ACTOR_ID AND X.DIRECTOR_ID = Y.DIRECTOR_ID AND Y.FREQ >= 3;

/*
Prediction Result:
(1028, 1029)
*/