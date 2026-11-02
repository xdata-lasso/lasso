-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-12-31', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2021-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-12-31', 1, 0.0)
*/

-- Prediction Query
WITH BASE_DATA AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY 1), INSTALLS AS (SELECT A.PLAYER_ID, B.INSTALL_DT, SUM(CASE WHEN EVENT_DATE = INSTALL_DT THEN 1 ELSE 0 END) AS INSTALLS FROM ACTIVITY AS A JOIN BASE_DATA AS B ON A.PLAYER_ID = B.PLAYER_ID GROUP BY 1), NEXT_DATE AS (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS ROW_NUM FROM ACTIVITY) SELECT A.INSTALL_DT, SUM(INSTALLS) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN B.EVENT_DATE - A.INSTALL_DT = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM INSTALLS AS A LEFT JOIN NEXT_DATE AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.ROW_NUM = 2 GROUP BY 1;

/*
Prediction Result:
('2020-12-31', 1, 1.0)
*/