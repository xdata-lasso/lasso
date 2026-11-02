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
WITH CTE AS (SELECT *, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RANK, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_LOGIN FROM ACTIVITY) SELECT INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(RETENTION, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM (SELECT EVENT_DATE AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM CTE WHERE CTE.RANK = 1 GROUP BY EVENT_DATE) AS A LEFT JOIN (SELECT EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS RETENTION FROM CTE WHERE CTE.RANK = 1 AND CAST((JULIANDAY(NEXT_LOGIN) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1 GROUP BY EVENT_DATE) AS B USING (INSTALL_DT) ORDER BY INSTALL_DT, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/