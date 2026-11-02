-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(None, 1, 0.0)
*/

-- Prediction Query
WITH INSTALLS AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY PLAYER_ID) SELECT INSTALL_DATE AS INSTALL_DT, SUM(CASE WHEN EVENT_DATE = INSTALL_DATE THEN 1 ELSE 0 END) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN EVENT_DATE = INSTALL_DATE + 1 THEN 1 ELSE 0 END) AS REAL) / SUM(CASE WHEN EVENT_DATE = INSTALL_DATE THEN 1 ELSE 0 END)), 2) AS DAY1_RETENTION FROM INSTALLS LEFT JOIN ACTIVITY ON INSTALLS.PLAYER_ID = ACTIVITY.PLAYER_ID GROUP BY INSTALL_DATE;

/*
Prediction Result:
(None, 0, None)
*/