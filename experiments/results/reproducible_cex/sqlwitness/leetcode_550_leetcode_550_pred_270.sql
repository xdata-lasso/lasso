-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-01', -1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TEMP1 AS (SELECT *, EVENT_DATE - LAG(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DIFF, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NUMBER FROM ACTIVITY), TEMP2 AS (SELECT COUNT(DISTINCT PLAYER_ID) AS PLAYER_NUM FROM ACTIVITY) SELECT ROUND(CAST(COUNT(DISTINCT PLAYER_ID) AS REAL) / TEMP2.PLAYER_NUM, 2) AS FRACTION FROM TEMP1 CROSS JOIN TEMP2 WHERE DIFF = 1 AND NUMBER <= 2;

/*
Prediction Result:
(None,)
*/