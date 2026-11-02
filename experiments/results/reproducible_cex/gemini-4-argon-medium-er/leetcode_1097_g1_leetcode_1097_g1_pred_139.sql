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
WITH CTE1 AS (SELECT * FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY 1)), CTE2 AS (SELECT CTE1.EVENT_DATE, COUNT(*) AS RETENTION_COUNT FROM CTE1 JOIN ACTIVITY AS A ON CTE1.PLAYER_ID = A.PLAYER_ID WHERE CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(CTE1.EVENT_DATE)) AS INTEGER) = 1 GROUP BY 1) SELECT CTE1.EVENT_DATE AS INSTALL_DT, COUNT(CTE1.PLAYER_ID) AS INSTALLS, ROUND(COALESCE(CAST(CTE2.RETENTION_COUNT AS REAL) / COUNT(CTE1.PLAYER_ID), 0), 2) AS DAY1_RETENTION FROM CTE1 LEFT JOIN CTE2 ON CTE1.EVENT_DATE = CTE2.EVENT_DATE GROUP BY 1 ORDER BY 1, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/