-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-01', 3, 2), (3, '2023-01-02', 0, NULL), (0, '2023-01-01', NULL, 1), (3, '2023-01-01', 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 3, 0.0)
*/

-- Prediction Query
WITH INSTALLDATE AS (SELECT PLAYER_ID, EVENT_DATE AS INSTALL_DATE FROM (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RK FROM ACTIVITY) AS A WHERE A.RK = 1), RETENTION AS (SELECT PLAYER_ID, INSTALL_DATE, IIF((PLAYER_ID, DATE(INSTALL_DATE, '1 DAY')) IN (SELECT PLAYER_ID, EVENT_DATE FROM ACTIVITY), 1, 0) AS HAS_NEXT FROM INSTALLDATE) SELECT INSTALL_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(HAS_NEXT) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM RETENTION GROUP BY INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 3, 0.33)
*/