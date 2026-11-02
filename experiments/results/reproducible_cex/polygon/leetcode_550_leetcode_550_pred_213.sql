-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (12, '0998-09-25', NULL, NULL);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (12, '1002-03-31', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH A AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS D FROM ACTIVITY GROUP BY PLAYER_ID) SELECT ROUND((CAST(COUNT(PLAYER_ID) AS REAL) / (SELECT COUNT(*) FROM A)), 2) AS FRACTION FROM (SELECT A.PLAYER_ID FROM A CROSS JOIN ACTIVITY AS A1 WHERE A.PLAYER_ID = A1.PLAYER_ID AND A.D + 1 = A1.EVENT_DATE) AS T1;

/*
Prediction Result:
(0.0,)
*/