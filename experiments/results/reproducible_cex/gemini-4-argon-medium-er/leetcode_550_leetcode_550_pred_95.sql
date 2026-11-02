-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TEMP AS (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RK FROM ACTIVITY) SELECT ROUND(CAST(COUNT(DISTINCT IIF(NOT T2.EVENT_DATE IS NULL, T2.PLAYER_ID, NULL)) AS REAL) / COUNT(DISTINCT T1.PLAYER_ID), 2) AS FRACTION FROM TEMP AS T1 LEFT JOIN TEMP AS T2 ON T1.PLAYER_ID = T2.PLAYER_ID AND T1.RK = 1 AND T2.RK = 2 AND CAST((JULIANDAY(T2.EVENT_DATE) - JULIANDAY(T1.EVENT_DATE)) AS INTEGER) = 1;

/*
Prediction Result:
(1.0,)
*/