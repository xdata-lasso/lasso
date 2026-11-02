-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (NULL, '2020-01-01', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 0, None)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT *, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_LOGIN, LAG(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS PREV_LOGIN FROM ACTIVITY) SELECT EVENT_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(IIF(NEXT_LOGIN = EVENT_DATE + 1, 1, 0)) AS REAL) / (COUNT(*)), 2) AS DAY1_RETENTION FROM FIRST_LOGIN WHERE PREV_LOGIN IS NULL GROUP BY EVENT_DATE ORDER BY EVENT_DATE, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-01-01', 1, 0.0)
*/