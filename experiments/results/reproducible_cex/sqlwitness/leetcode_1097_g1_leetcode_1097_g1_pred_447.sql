-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1000, '2024-09-23', -1, 2), (-1000, '2025-06-29', 2, NULL), (-1000, '2024-07-14', 0, 2), (-1000, '2026-09-09', 3, 2), (-1000, '2025-01-22', 0, 3), (-1000, '2026-06-25', NULL, NULL), (2, '2023-01-02', 3, 2), (0, '2023-01-02', 2, 2), (3, '2023-01-02', 1, 1), (-1, '2023-01-02', 0, 2), (0, '2023-01-01', -1, 2), (-1, '2023-01-01', 0, NULL), (3, '2023-01-01', 3, 2), (2, '2023-01-01', NULL, NULL), (-1000, '2024-06-02', -1, 1), (-1000, '2024-05-08', 1, 2), (1, '2023-01-02', NULL, 2), (1, '2023-01-01', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 5, 0.0)
('2024-05-08', 1, 0.0)
*/

-- Prediction Query
WITH DF1 AS (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS INSTALL_DATE, EVENT_DATE - MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS GAP FROM ACTIVITY) SELECT INSTALL_DATE AS INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS, ROUND(CAST(1.00 * SUM(CASE WHEN GAP = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS DAY1_RETENTION FROM DF1 GROUP BY 1;

/*
Prediction Result:
('2023-01-01', 5, 0.0)
('2024-05-08', 1, 2.0)
*/