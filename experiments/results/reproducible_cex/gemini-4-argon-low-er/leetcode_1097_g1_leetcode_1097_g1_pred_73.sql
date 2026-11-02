-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 1, 0.0)
*/

-- Prediction Query
WITH T AS (SELECT PLAYER_ID, EVENT_DATE, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS R FROM ACTIVITY), N AS (SELECT T1.PLAYER_ID AS PID1, T1.EVENT_DATE AS D1, T1.R, T2.PLAYER_ID AS PID2, T2.EVENT_DATE AS D2, CASE WHEN NOT T2.PLAYER_ID IS NULL THEN 1 ELSE 0 END AS STAY FROM T AS T1 LEFT JOIN T AS T2 ON DATE(T1.EVENT_DATE, '1 DAY') = T2.EVENT_DATE AND T1.PLAYER_ID = T2.PLAYER_ID WHERE T1.R = 1) SELECT DISTINCT D1 AS INSTALL_DT, SUM(R) AS INSTALLS, ROUND(CAST(SUM(STAY) AS REAL) / SUM(R), 2) AS DAY1_RETENTION FROM N GROUP BY D1;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/