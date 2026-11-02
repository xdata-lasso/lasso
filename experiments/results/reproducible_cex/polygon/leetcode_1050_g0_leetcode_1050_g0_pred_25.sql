-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (5, 7, 6);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (4, 6, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY ACTOR_ID, DIRECTOR_ID HAVING COUNT(TIMESTAMP) >= 3) SELECT * FROM TEMP;

/*
Prediction Result:
*/