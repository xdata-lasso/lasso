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
WITH CTE AS (SELECT A.PLAYER_ID, A.EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY A.PLAYER_ID ORDER BY A.EVENT_DATE ASC) AS RANK_DATE, LEAD(A.EVENT_DATE, 1) OVER (PARTITION BY A.PLAYER_ID ORDER BY A.EVENT_DATE ASC) AS NEXT_DATE FROM ACTIVITY AS A) SELECT R.EVENT_DATE AS INSTALL_DT, COUNT(R.PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN R.NEXT_DATE = DATE(R.EVENT_DATE, '1 DAY') THEN 1 ELSE 0 END) * 1.0 AS REAL) / COUNT(R.PLAYER_ID), 2) AS DAY1_RETENTION FROM CTE AS R WHERE R.RANK_DATE = 1 GROUP BY R.EVENT_DATE;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/