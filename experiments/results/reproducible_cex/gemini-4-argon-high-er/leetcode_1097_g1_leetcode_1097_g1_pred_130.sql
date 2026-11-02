-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT * FROM (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS T1 WHERE RNK < 3), CTE2 AS (SELECT PLAYER_ID, MAX(CASE WHEN RNK = 1 THEN EVENT_DATE END) AS INSTALL_DATE, MAX(CASE WHEN RNK = 2 THEN EVENT_DATE END) AS DAY2 FROM CTE GROUP BY PLAYER_ID) SELECT INSTALL_DATE AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN NOT DAY2 IS NULL AND CAST((JULIANDAY(DAY2) - JULIANDAY(INSTALL_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT PLAYER_ID)), 2) AS DAY1_RETENTION FROM CTE2 GROUP BY INSTALL_DATE ORDER BY INSTALL_DATE, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/