-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH T AS (SELECT PLAYER_ID, EVENT_DATE, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_DAY FROM ACTIVITY), T1 AS (SELECT EVENT_DATE, COUNT(DISTINCT PLAYER_ID) AS TOTAL FROM T WHERE RNK = 1 GROUP BY 1), T2 AS (SELECT EVENT_DATE, COUNT(DISTINCT PLAYER_ID) AS RETENTION FROM (SELECT PLAYER_ID, EVENT_DATE, RNK, CAST((JULIANDAY(NEXT_DAY) - JULIANDAY(EVENT_DATE)) AS INTEGER) AS DATE_DIFF FROM T) AS TEMP WHERE DATE_DIFF = 1 AND RNK = 1 GROUP BY 1) SELECT T1.EVENT_DATE AS INSTALL_DT, TOTAL AS INSTALLS, ROUND(COALESCE(CAST(RETENTION AS REAL) / TOTAL, 0), 2) AS DAY1_RETENTION FROM T1 LEFT JOIN T2 ON T1.EVENT_DATE = T2.EVENT_DATE;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/