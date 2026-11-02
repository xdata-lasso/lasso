-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 2, 3), (3, '2023-01-02', NULL, 1), (-1, '2023-01-02', NULL, 0), (3, '2023-01-01', 2, 2), (-1, '2023-01-01', NULL, NULL), (0, '2023-01-01', 1, 1), (1, '2023-01-01', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 4, 0.0)
('2023-01-02', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), CTE2 AS (SELECT A2.PLAYER_ID, A2.INSTALL_DT FROM ACTIVITY AS A1 JOIN CTE AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = DATE(A2.INSTALL_DT, '1 DAY')) SELECT C1.INSTALL_DT, COUNT(C1.INSTALL_DT) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN C2.INSTALL_DT IS NULL THEN 0 ELSE 1 END) AS REAL) / COUNT(C1.INSTALL_DT), 2) AS DAY1_RETENTION FROM CTE AS C1 LEFT JOIN CTE2 AS C2 ON C1.INSTALL_DT = C2.INSTALL_DT AND C1.PLAYER_ID = C2.PLAYER_ID GROUP BY C1.INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 4, 0.5)
('2023-01-02', 1, 0.0)
*/