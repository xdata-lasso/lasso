-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-02', -1, 3), (0, '2023-01-02', -1, 3), (0, '2023-01-01', 3, 0), (2, '2023-01-01', 0, 3);
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
WITH CTE1 AS (SELECT MIN(EVENT_DATE) AS INSTALL_DT, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID), CTE2 AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM CTE1 GROUP BY INSTALL_DT), CTE3 AS (SELECT CTE1.PLAYER_ID, INSTALL_DT, DATE(INSTALL_DT, '1 DAY') AS SECOND_DAY FROM CTE1), CTE4 AS (SELECT CTE3.PLAYER_ID, CTE3.INSTALL_DT FROM CTE3 JOIN ACTIVITY AS A ON CTE3.PLAYER_ID = A.PLAYER_ID AND CTE3.SECOND_DAY = A.EVENT_DATE), CTE5 AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS NUM1 FROM CTE4 GROUP BY INSTALL_DT) SELECT CTE2.INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(NUM1, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM CTE2 LEFT JOIN CTE5 ON CTE2.INSTALL_DT = CTE5.INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 1, 0.0)
*/