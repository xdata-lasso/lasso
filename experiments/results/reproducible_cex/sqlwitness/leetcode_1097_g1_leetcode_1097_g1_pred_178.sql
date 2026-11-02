-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (0, '2023-01-02', 1, 0), (3, '2023-01-01', 0, 0), (2, '2023-01-02', 3, 0), (3, '2023-01-02', 1, 0), (1, '2023-01-01', 2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
('2023-01-02', 2, 0.0)
*/

-- Prediction Query
WITH T1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY 1), T2 AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM T1 GROUP BY 1), T3 AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS RETENTION FROM T1 WHERE (PLAYER_ID, DATE(INSTALL_DT, '1 DAY')) IN (SELECT PLAYER_ID, EVENT_DATE FROM ACTIVITY) GROUP BY 1) SELECT T2.INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(RETENTION, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM T2 LEFT JOIN T3 ON T2.INSTALL_DT = T3.INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 2, 0.0)
*/