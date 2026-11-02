-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 10, 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 10.5, 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 11, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(10, 1, 1.0)
*/

-- Prediction Query
WITH TEMP1 AS (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RN FROM ACTIVITY) SELECT INSTALL_DT, INSTALLS, ROUND(CAST(NUM AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM (SELECT INSTALL_DT, COUNT(DISTINCT A.PLAYER_ID) AS INSTALLS, COALESCE(COUNT(DISTINCT B.PLAYER_ID), 0) AS NUM FROM (SELECT DISTINCT A.EVENT_DATE AS INSTALL_DT, T.PLAYER_ID FROM ACTIVITY AS A LEFT JOIN TEMP1 AS T ON A.EVENT_DATE = T.EVENT_DATE WHERE T.RN = 1) AS A LEFT JOIN (SELECT DISTINCT EVENT_DATE, PLAYER_ID FROM TEMP1 WHERE RN = 2) AS B ON A.INSTALL_DT = B.EVENT_DATE - 1 AND A.PLAYER_ID = B.PLAYER_ID GROUP BY INSTALL_DT) AS X;

/*
Prediction Result:
(10, 1, 0.0)
*/