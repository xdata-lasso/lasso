-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (NULL, 1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(1, 0, None)
*/

-- Prediction Query
WITH T1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), T2 AS (SELECT A.PLAYER_ID, B.INSTALL_DT, A.EVENT_DATE FROM ACTIVITY AS A LEFT JOIN T1 AS B ON A.PLAYER_ID = B.PLAYER_ID WHERE A.EVENT_DATE = B.INSTALL_DT + 1), T3 AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM T1 GROUP BY INSTALL_DT), T4 AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS DAY1 FROM T2 GROUP BY INSTALL_DT) SELECT A.INSTALL_DT, A.INSTALLS, CASE WHEN NOT B.DAY1 IS NULL THEN ROUND(CAST(B.DAY1 AS REAL) / A.INSTALLS, 2) ELSE ROUND(0, 2) END AS DAY1_RETENTION FROM T3 AS A LEFT JOIN T4 AS B ON A.INSTALL_DT = B.INSTALL_DT;

/*
Prediction Result:
(1, 0, 0.0)
*/