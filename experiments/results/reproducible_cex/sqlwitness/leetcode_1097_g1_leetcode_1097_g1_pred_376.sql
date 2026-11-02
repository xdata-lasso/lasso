-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', NULL, 2), (0, '2023-01-02', 0, 0), (0, '2023-01-01', 2, 2), (3, '2023-01-01', -1, 0), (-1, '2023-01-01', 0, 3);
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
WITH T1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY AS A GROUP BY PLAYER_ID), T2 AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM T1 GROUP BY INSTALL_DT) SELECT T1.INSTALL_DT, INSTALLS, ROUND(CAST(SUM(IIF(A.EVENT_DATE IS NULL, 0, 1)) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM T1 JOIN T2 ON T2.INSTALL_DT = T1.INSTALL_DT LEFT JOIN ACTIVITY AS A ON A.PLAYER_ID = T1.PLAYER_ID AND EVENT_DATE = (DATE(T1.INSTALL_DT, '+1 day')) GROUP BY T1.INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 3, 0.33)
('2023-01-02', 1, 0.0)
*/