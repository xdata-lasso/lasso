-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20230501, 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20230502, 2, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20230501, 3, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20230510, 1, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20230512, 4, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.33,)
*/

-- Prediction Query
WITH TMP AS (SELECT PLAYER_ID, EVENT_DATE, LAG(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS LAST_EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RANKING FROM ACTIVITY), TMP2 AS (SELECT COUNT(*) AS TOTAL FROM (SELECT DISTINCT PLAYER_ID FROM ACTIVITY) AS TMP3) SELECT ROUND(CAST(COUNT(*) AS REAL) / TMP5.TOTAL, 2) AS FRACTION FROM (SELECT DISTINCT T1.PLAYER_ID, T2.TOTAL FROM TMP AS T1 CROSS JOIN TMP2 AS T2 WHERE T1.RANKING = 2 AND (NOT (LAST_EVENT_DATE IS NULL)) AND CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(LAST_EVENT_DATE)) AS INTEGER) = '1') AS TMP5;

/*
Prediction Result:
(None,)
*/