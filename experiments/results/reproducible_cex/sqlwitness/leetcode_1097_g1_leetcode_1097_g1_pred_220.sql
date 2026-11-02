-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (0, '2023-01-02', -1, 0), (3, '2023-01-02', NULL, NULL), (0, '2023-01-01', 3, 2), (3, '2023-01-01', NULL, 1), (-1, '2023-01-01', 0, 3), (-1, '2023-01-02', 2, 3), (1, '2023-01-02', -1, 0), (1, '2023-01-01', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 4, 0.0)
*/

-- Prediction Query
WITH DATES_BY_PLAYER AS (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RN FROM ACTIVITY), FIRST_JOIN AS (SELECT PLAYER_ID, EVENT_DATE FROM DATES_BY_PLAYER WHERE RN = 1), INSTALL_RETENTION AS (SELECT T1.EVENT_DATE AS INSTALL_DT, T2.EVENT_DATE AS RETENTION_DATE FROM DATES_BY_PLAYER AS T1 LEFT JOIN DATES_BY_PLAYER AS T2 ON DATE(T1.EVENT_DATE, '+1 day') = T2.EVENT_DATE AND T1.PLAYER_ID = T2.PLAYER_ID WHERE T1.RN = 1) SELECT INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN NOT RETENTION_DATE IS NULL THEN 1 ELSE 0 END) * 1.00 AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM INSTALL_RETENTION GROUP BY INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 4, 1.0)
*/