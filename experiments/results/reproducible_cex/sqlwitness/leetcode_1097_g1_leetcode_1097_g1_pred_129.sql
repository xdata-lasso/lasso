-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', 0, 0), (2, '2023-01-02', 3, 0), (3, '2023-01-02', 0, 1), (2, '2023-01-01', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
('2023-01-02', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RN FROM ACTIVITY), CTE1 AS (SELECT T1.EVENT_DATE, T1.PLAYER_ID AS T1P, CASE WHEN T2.PLAYER_ID IS NULL THEN 0 ELSE 1 END AS T2P FROM (SELECT EVENT_DATE, PLAYER_ID FROM CTE WHERE RN = 1) AS T1 LEFT JOIN (SELECT EVENT_DATE, PLAYER_ID FROM CTE WHERE RN = 2) AS T2 ON T1.PLAYER_ID = T2.PLAYER_ID AND DATE(T1.EVENT_DATE, '1 DAY') = T2.EVENT_DATE) SELECT EVENT_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(T2P) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM CTE1 GROUP BY EVENT_DATE;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 1, 0.0)
*/