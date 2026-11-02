-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1000, '2024-09-23', 3, NULL), (-1000, '2025-06-29', 0, NULL), (-1000, '2024-07-14', 2, 2), (-1000, '2026-09-09', 0, 1), (-1000, '2025-01-22', 1, 2), (-1000, '2026-06-25', 3, 0), (2, '2023-01-02', 1, 3), (2, '2023-01-01', 0, NULL), (3, '2023-01-02', 0, 1), (-1, '2023-01-02', -1, 1), (3, '2023-01-01', NULL, NULL), (0, '2023-01-02', -1, 2), (-1, '2023-01-01', 2, 0), (0, '2023-01-01', 3, NULL), (-1000, '2024-06-02', 1, 2), (-1000, '2024-05-08', 2, NULL), (1, '2023-01-02', 0, 1), (1, '2023-01-01', 3, 1);
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
SELECT DISTINCT FIRST_DAY AS INSTALL_DT, SUM(CASE WHEN EVENT_DATE = FIRST_DAY THEN 1 ELSE 0 END) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN EVENT_DATE - FIRST_DAY = 1 THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN EVENT_DATE = FIRST_DAY THEN 1 ELSE 0 END), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, FIRST_VALUE(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS FIRST_DAY, EVENT_DATE FROM ACTIVITY) AS TBL GROUP BY FIRST_DAY;

/*
Prediction Result:
('2023-01-01', 5, 0.0)
('2024-05-08', 1, 2.0)
*/