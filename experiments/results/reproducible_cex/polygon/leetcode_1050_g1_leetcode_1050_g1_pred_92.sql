-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (6, 6, 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT ACTOR_ID, DIRECTOR_ID FROM (SELECT ACTOR_ID, DIRECTOR_ID, RANK() OVER (PARTITION BY ACTOR_ID, DIRECTOR_ID ORDER BY TIMESTAMP ASC) AS COOP FROM ACTORDIRECTOR) AS B WHERE COOP >= 3;

/*
Prediction Result:
*/