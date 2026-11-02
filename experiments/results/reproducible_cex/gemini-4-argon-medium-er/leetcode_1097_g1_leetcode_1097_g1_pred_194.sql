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
WITH TEMP AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT, DATE(MIN(EVENT_DATE), '1 DAY') AS NEXT_DAY FROM ACTIVITY GROUP BY PLAYER_ID), TEMP2 AS (SELECT TEMP.*, ACTIVITY.DEVICE_ID FROM TEMP LEFT JOIN ACTIVITY ON TEMP.PLAYER_ID = ACTIVITY.PLAYER_ID AND TEMP.NEXT_DAY = ACTIVITY.EVENT_DATE) SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(DEVICE_ID) AS REAL) / COUNT(PLAYER_ID), 2) AS DAY1_RETENTION FROM TEMP2 GROUP BY INSTALL_DT ORDER BY INSTALL_DT, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/