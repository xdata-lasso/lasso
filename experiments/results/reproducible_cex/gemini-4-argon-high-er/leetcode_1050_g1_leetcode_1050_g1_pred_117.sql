-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (1, 1, NULL);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (2, 1, NULL);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (3, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ACTOR_ID, DIRECTOR_ID FROM ACTORDIRECTOR GROUP BY DIRECTOR_ID, ACTOR_ID HAVING COUNT(ACTOR_ID) > 2;

/*
Gold Result:
(1, None)
*/

-- Prediction Query
WITH A AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(DIRECTOR_ID) AS X, COUNT(ACTOR_ID) AS Y FROM ACTORDIRECTOR WHERE CASE WHEN ACTOR_ID = DIRECTOR_ID OR ACTOR_ID <> DIRECTOR_ID THEN 1 ELSE 0 END GROUP BY 1, 2) SELECT DISTINCT A.ACTOR_ID, A.DIRECTOR_ID FROM A LEFT JOIN A AS B ON A.DIRECTOR_ID = B.DIRECTOR_ID WHERE A.X = A.Y AND A.X >= 3 AND A.Y >= 3;

/*
Prediction Result:
*/