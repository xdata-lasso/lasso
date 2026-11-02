-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (14, '0999-08-25', 18, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(A3.F1 AS REAL) / COUNT(DISTINCT (ACT.PLAYER_ID)), 2) AS FRACTION FROM ACTIVITY AS ACT CROSS JOIN (SELECT COUNT(DISTINCT (A2.PLAYER_ID)) AS F1 FROM (SELECT DISTINCT (PLAYER_ID) AS ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS TEMP CROSS JOIN ACTIVITY AS A2 WHERE TEMP.ID = A2.PLAYER_ID AND TEMP.EVENT_DATE + 1 = A2.EVENT_DATE) AS A3;

/*
Prediction Result:
(0.0,)
*/