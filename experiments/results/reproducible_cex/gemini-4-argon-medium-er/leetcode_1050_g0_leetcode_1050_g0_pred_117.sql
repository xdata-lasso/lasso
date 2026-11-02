-- Schema DDL
CREATE TABLE "ActorDirector" ("timestamp" INTEGER PRIMARY KEY, "actor_id" INTEGER, "director_id" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (1, NULL, 1);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (2, NULL, 1);
INSERT INTO "ActorDirector" ("timestamp", "actor_id", "director_id") VALUES (3, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT actor_id, director_id FROM ActorDirector GROUP BY actor_id, director_id HAVING COUNT(*) >= 3;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
WITH A AS (SELECT ACTOR_ID, DIRECTOR_ID, COUNT(DIRECTOR_ID) AS X, COUNT(ACTOR_ID) AS Y FROM ACTORDIRECTOR WHERE CASE WHEN ACTOR_ID = DIRECTOR_ID OR ACTOR_ID <> DIRECTOR_ID THEN 1 ELSE 0 END GROUP BY 1, 2) SELECT DISTINCT A.ACTOR_ID, A.DIRECTOR_ID FROM A LEFT JOIN A AS B ON A.DIRECTOR_ID = B.DIRECTOR_ID WHERE A.X = A.Y AND A.X >= 3 AND A.Y >= 3;

/*
Prediction Result:
*/