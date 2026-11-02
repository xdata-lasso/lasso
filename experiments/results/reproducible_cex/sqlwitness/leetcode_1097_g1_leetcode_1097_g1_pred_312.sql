-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 1, 1), (0, '2023-01-02', 3, 2), (3, '2023-01-02', 0, 1), (0, '2023-01-01', NULL, 0), (2, '2023-01-01', 0, 1), (1, '2023-01-02', 2, 0), (1, '2023-01-01', 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 3, 0.0)
('2023-01-02', 1, 0.0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS INSTALL_DT, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_EVENT FROM ACTIVITY), CTE2 AS (SELECT PLAYER_ID, INSTALL_DT, IIF(NEXT_EVENT = DATE(INSTALL_DT, '1 DAY'), 1, NULL) AS FLAG_RETENTION FROM CTE1) SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(FLAG_RETENTION) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS DAY1_RETENTION FROM CTE2 GROUP BY INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 3, 1.0)
('2023-01-02', 1, 0.0)
*/