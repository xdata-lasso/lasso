-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-01', 2, 2), (0, '2023-01-02', 0, NULL), (-1, '2023-01-02', NULL, 3), (3, '2023-01-01', 0, 3), (0, '2023-01-01', 0, 1), (-1, '2023-01-01', -1, 1), (1, '2023-01-02', NULL, 1), (1, '2023-01-01', -1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 5, 0.0)
*/

-- Prediction Query
WITH D AS (SELECT EVENT_DATE AS INSTALL_DT, PLAYER_ID, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS INSTALLS, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS CONSECUTIVE_DATE, CAST((JULIANDAY(LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE)) - JULIANDAY(EVENT_DATE)) AS INTEGER) AS OTHER_DIFFERENCE FROM ACTIVITY) SELECT INSTALL_DT, COUNT(INSTALLS) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN OTHER_DIFFERENCE = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(INSTALLS), 2) AS DAY1_RETENTION FROM D WHERE INSTALLS = 1 GROUP BY INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 5, 0.6)
*/