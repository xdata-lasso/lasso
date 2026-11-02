-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (9, '0998-09-25', -463, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (11, '0998-09-26', -463, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('0998-09-25', 1, 0.0)
('0998-09-26', 1, 0.0)
*/

-- Prediction Query
WITH MIN_DATE AS (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS INSTALL_DT FROM ACTIVITY) SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(CASE WHEN CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(INSTALL_DT)) AS INTEGER) = 1 THEN 1 END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS DAY1_RETENTION FROM MIN_DATE GROUP BY INSTALL_DT;

/*
Prediction Result:
('0998-09-25', 1, 0.0)
('0998-09-26', 1, 0.0)
*/