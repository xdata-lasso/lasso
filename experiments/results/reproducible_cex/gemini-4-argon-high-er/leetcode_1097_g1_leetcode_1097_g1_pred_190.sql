-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 1, 0.0)
*/

-- Prediction Query
WITH TEMP AS (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS FIRST_DAY FROM ACTIVITY) SELECT A.FIRST_DAY AS INSTALL_DT, A.TOTAL AS INSTALLS, ROUND(COALESCE(CAST(RETENTION AS REAL) / TOTAL, 0), 2) AS DAY1_RETENTION FROM (SELECT FIRST_DAY, COUNT(DISTINCT PLAYER_ID) AS TOTAL FROM TEMP GROUP BY FIRST_DAY) AS A LEFT JOIN (SELECT FIRST_DAY, SUM(CASE WHEN CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(FIRST_DAY)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS RETENTION FROM TEMP GROUP BY FIRST_DAY) AS B ON A.FIRST_DAY = B.FIRST_DAY;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/