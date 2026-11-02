-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-01', 1, NULL), (0, '2023-01-01', 1, NULL), (0, '2023-01-02', -1, 0), (2, '2023-01-02', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
*/

-- Prediction Query
WITH T2 AS (SELECT PLAYER_ID, MIN(CASE WHEN RNUM = 1 THEN EVENT_DATE ELSE NULL END) AS INSTALL_DT, MIN(CASE WHEN RNUM = 2 THEN EVENT_DATE ELSE NULL END) AS NEXT_LOGIN FROM (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNUM FROM ACTIVITY) AS T1 WHERE RNUM <= 2 GROUP BY PLAYER_ID) SELECT INSTALL_DT, COUNT(1) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN CAST((JULIANDAY(NEXT_LOGIN) - JULIANDAY(INSTALL_DT)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(1), 2) AS DAY1_RETENTION FROM T2 GROUP BY INSTALL_DT ORDER BY INSTALL_DT, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2023-01-01', 2, 1.0)
*/