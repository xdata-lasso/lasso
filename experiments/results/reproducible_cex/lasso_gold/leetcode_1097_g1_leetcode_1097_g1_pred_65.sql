-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1166, '1973-03-12', 1168, 1169);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1166, '1973-03-13', 1158, 1159);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('1973-03-12', 1, 0.0)
*/

-- Prediction Query
WITH MAIN AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) SELECT INSTALL_DT, COUNT(MAIN.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(EVENT_DATE) AS REAL) / COUNT(MAIN.PLAYER_ID), 2) AS DAY1_RETENTION FROM MAIN LEFT JOIN ACTIVITY ON MAIN.PLAYER_ID = ACTIVITY.PLAYER_ID AND CAST((JULIANDAY(ACTIVITY.EVENT_DATE) - JULIANDAY(MAIN.INSTALL_DT)) AS INTEGER) = 1 GROUP BY INSTALL_DT;

/*
Prediction Result:
('1973-03-12', 1, 1.0)
*/