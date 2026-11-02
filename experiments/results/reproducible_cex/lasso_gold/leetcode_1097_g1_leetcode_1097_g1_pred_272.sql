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
WITH TEMP1 AS (SELECT *, CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(LOGIN_DATE)) AS INTEGER) AS DIFF FROM (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS LOGIN_DATE FROM ACTIVITY) AS T1) SELECT T1.LOGIN_DATE AS INSTALL_DT, INSTALLS, ROUND(COALESCE(CAST(DAY_RETENTION AS REAL) / INSTALLS, 0), 2) AS DAY1_RETENTION FROM (SELECT LOGIN_DATE, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM TEMP1 GROUP BY LOGIN_DATE) AS T1 LEFT JOIN (SELECT LOGIN_DATE, COALESCE(COUNT(IIF(DIFF = 1, 1, NULL)), 0) AS DAY_RETENTION FROM TEMP1 GROUP BY LOGIN_DATE) AS T2 ON T1.LOGIN_DATE = T2.LOGIN_DATE;

/*
Prediction Result:
('1973-03-12', 1, 1.0)
*/