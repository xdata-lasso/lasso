-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (0, '2023-01-01', -1, 3), (1, '2023-01-01', 3, 3), (-1, '2023-01-01', NULL, 0), (-1, '2023-01-02', 0, 0), (3, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 4, 0.0)
*/

-- Prediction Query
WITH A AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS LAG1_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RK FROM ACTIVITY), B AS (SELECT * FROM A WHERE RK = 1), C AS (SELECT EVENT_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, SUM(CASE WHEN CAST((JULIANDAY(LAG1_DATE) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS CT FROM B GROUP BY EVENT_DATE) SELECT INSTALL_DT, INSTALLS, ROUND(CAST(CT AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM C;

/*
Prediction Result:
('2023-01-01', 4, 0.25)
*/