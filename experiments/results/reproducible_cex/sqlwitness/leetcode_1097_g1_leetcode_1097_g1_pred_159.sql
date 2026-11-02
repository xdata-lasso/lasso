-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', NULL, 0), (0, '2023-01-01', 2, NULL), (0, '2023-01-02', 1, 3), (2, '2023-01-01', 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
*/

-- Prediction Query
WITH INSTALL_DT AS (SELECT DISTINCT EVENT_DATE AS INSTALL_DT, PLAYER_ID FROM (SELECT PLAYER_ID, EVENT_DATE, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RANK_ FROM ACTIVITY) AS TMP WHERE RANK_ = 1) SELECT T1.INSTALL_DT, COUNT(T1.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(T2.PLAYER_ID) * 1.0 AS REAL) / COUNT(T1.PLAYER_ID), 2) AS DAY1_RETENTION FROM INSTALL_DT AS T1 LEFT JOIN ACTIVITY AS T2 ON T1.PLAYER_ID = T2.PLAYER_ID AND DATE(T1.INSTALL_DT, '1 DAY') = T2.EVENT_DATE GROUP BY T1.INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 2, 1.0)
*/