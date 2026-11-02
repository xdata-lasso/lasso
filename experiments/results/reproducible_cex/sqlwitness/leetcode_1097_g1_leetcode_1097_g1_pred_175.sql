-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1000, '2024-11-29', 3, 0), (-1000, '2025-06-29', 3, 3), (-1000, '2026-08-05', 3, NULL), (-1000, '2024-06-02', 2, NULL), (1, '2023-01-02', 3, 2), (1, '2023-01-01', 3, NULL), (-1000, '2024-09-23', 2, 3), (-1000, '2025-12-25', 1, 1), (-1000, '2024-07-14', 2, 0), (-1000, '2026-06-25', 2, 3), (3, '2023-01-02', 2, NULL), (3, '2023-01-01', NULL, 3), (-1000, '2024-05-08', 2, 0), (-1000, '2026-09-09', NULL, 0), (-1000, '2026-02-09', 0, 3), (-1000, '2026-08-03', 3, 0), (-1000, '2026-09-07', NULL, 1), (-1000, '2025-06-27', NULL, 2), (2, '2023-01-02', NULL, 3), (0, '2023-01-02', 0, 3), (2, '2023-01-01', 1, 3), (0, '2023-01-01', 2, 0), (-1000, '2025-02-27', 0, 0), (-1000, '2025-01-22', 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 4, 0.0)
('2024-05-08', 1, 0.0)
*/

-- Prediction Query
WITH RETENTION AS (SELECT PLAYER_ID, INSTALL_DT FROM (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS INSTALL_DT FROM ACTIVITY) AS T WHERE EVENT_DATE - INSTALL_DT = 1), INSTALL_DATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) SELECT A.INSTALL_DT, COUNT(A.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(B.PLAYER_ID) AS REAL) / COUNT(A.PLAYER_ID), 2) AS DAY1_RETENTION FROM INSTALL_DATE AS A LEFT JOIN RETENTION AS B ON A.PLAYER_ID = B.PLAYER_ID GROUP BY A.INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 4, 0.0)
('2024-05-08', 5, 1.0)
*/