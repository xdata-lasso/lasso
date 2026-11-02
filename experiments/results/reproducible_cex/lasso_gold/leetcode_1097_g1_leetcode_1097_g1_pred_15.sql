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
SELECT INSTALL_DT, COUNT(DISTINCT SUB.PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN A.EVENT_DATE IS NULL THEN 0 ELSE 1 END) AS REAL) / COUNT(DISTINCT SUB.PLAYER_ID), 2) AS DAY1_RETENTION FROM (SELECT *, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS INSTALL_DT FROM ACTIVITY) AS SUB LEFT JOIN ACTIVITY AS A ON DATE(SUB.EVENT_DATE, '1 DAY') = A.EVENT_DATE AND SUB.PLAYER_ID = A.PLAYER_ID WHERE SUB.EVENT_DATE = INSTALL_DT GROUP BY INSTALL_DT;

/*
Prediction Result:
('1973-03-12', 1, 1.0)
*/