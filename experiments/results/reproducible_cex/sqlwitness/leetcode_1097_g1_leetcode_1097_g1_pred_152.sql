-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1000, '2024-09-23', 1, 1), (-1000, '2025-12-25', 1, 0), (-1000, '2025-06-29', 3, 3), (-1000, '2024-07-14', 0, 3), (-1000, '2026-09-09', 1, 2), (-1000, '2026-06-25', 3, NULL), (2, '2023-01-02', 2, 0), (2, '2023-01-01', 0, 3), (3, '2023-01-02', 1, 1), (0, '2023-01-02', 2, 1), (3, '2023-01-01', 3, 0), (0, '2023-01-01', 0, 0), (-1000, '2024-06-02', 3, 3), (-1000, '2025-01-22', 3, 3), (-1000, '2024-05-08', 1, NULL), (1, '2023-01-02', NULL, 0), (1, '2023-01-01', 2, 1);
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
WITH INST AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), RETENTION AS (SELECT I.PLAYER_ID, I.INSTALL_DATE FROM INST AS I LEFT JOIN ACTIVITY AS A ON I.PLAYER_ID = A.PLAYER_ID WHERE A.EVENT_DATE - I.INSTALL_DATE = 1) SELECT L.INSTALL_DATE AS INSTALL_DT, COUNT(DISTINCT L.PLAYER_ID) AS INSTALLS, ROUND((CAST(COUNT(DISTINCT R.PLAYER_ID) AS REAL) / COUNT(DISTINCT L.PLAYER_ID)), 2) AS DAY1_RETENTION FROM INST AS L LEFT JOIN RETENTION AS R ON L.PLAYER_ID = R.PLAYER_ID GROUP BY 1;

/*
Prediction Result:
('2023-01-01', 4, 0.0)
('2024-05-08', 1, 1.0)
*/