-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', -1, NULL), (2, '2023-01-01', -1, 0), (0, '2023-01-02', 2, NULL), (0, '2023-01-01', NULL, 1), (3, '2023-01-01', NULL, 3), (-1, '2023-01-01', 1, 0), (-1, '2023-01-02', -1, 2), (1, '2023-01-02', 3, 3), (1, '2023-01-01', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 5, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RN FROM ACTIVITY) SELECT * FROM (SELECT EVENT_DATE AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(COALESCE(CAST(COUNT(ID2) AS REAL) / COUNT(PLAYER_ID), 0), 2) AS DAY1_RETENTION FROM (SELECT C1.EVENT_DATE, C1.RN, CASE WHEN C1.RN = 1 THEN C1.PLAYER_ID ELSE NULL END AS PLAYER_ID, CASE WHEN C1.RN = 1 THEN C2.PLAYER_ID ELSE NULL END AS ID2 FROM CTE AS C1 LEFT JOIN CTE AS C2 ON C1.PLAYER_ID = C2.PLAYER_ID AND DATE(C1.EVENT_DATE, '1 DAY') = C2.EVENT_DATE) AS TEMP GROUP BY INSTALL_DT) AS TEMP2 WHERE INSTALLS > 0 ORDER BY INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 5, 0.8)
*/