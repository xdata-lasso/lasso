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
WITH T AS (SELECT *, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RK, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXTD FROM ACTIVITY) SELECT EVENT_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(COUNT(IIF(EVENT_DATE = DATE(NEXTD, '-1 day'), PLAYER_ID, NULL)) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM T WHERE RK = 1 GROUP BY EVENT_DATE;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/