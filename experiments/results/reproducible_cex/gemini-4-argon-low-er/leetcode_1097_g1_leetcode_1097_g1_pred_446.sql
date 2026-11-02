-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
SELECT INSTALL_DATE AS INSTALL_DT, SUM(INSTALL_DT) AS INSTALLS, ROUND((CAST(SUM(RETENTION) AS REAL) / SUM(INSTALL_DT)), 2) AS DAY1_RETENTION FROM (SELECT INSTALL_DATE, CASE WHEN CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(INSTALL_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END AS RETENTION, CASE WHEN EVENT_DATE = INSTALL_DATE THEN 1 ELSE 0 END AS INSTALL_DT FROM (SELECT * FROM (SELECT PLAYER_ID, EVENT_DATE AS INSTALL_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS INSTALL_RANK FROM ACTIVITY) AS INSTALL_RNK WHERE INSTALL_RANK = 1) AS INSTALL_DT LEFT JOIN ACTIVITY AS B ON INSTALL_DT.PLAYER_ID = B.PLAYER_ID) AS A GROUP BY INSTALL_DATE;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/