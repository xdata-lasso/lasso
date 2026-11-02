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
WITH INSTALLS AS (SELECT EVENT_DATE AS INSTALL_DATE, PLAYER_ID FROM (SELECT EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DAY_N, PLAYER_ID FROM ACTIVITY) AS T WHERE DAY_N = 1), INS AS (SELECT INSTALL_DATE, COUNT(PLAYER_ID) AS CNT FROM INSTALLS GROUP BY INSTALL_DATE), RETENTIONS AS (SELECT PLAYER_ID, INSTALL_DATE, CASE WHEN DATE(INSTALL_DATE, '1 DAY') IN (SELECT EVENT_DATE FROM ACTIVITY WHERE PLAYER_ID = T.PLAYER_ID) THEN 1 ELSE 0 END AS RETENTION FROM INSTALLS AS T), RET AS (SELECT INSTALL_DATE, SUM(RETENTION) AS CNT FROM RETENTIONS GROUP BY INSTALL_DATE) SELECT I.INSTALL_DATE AS INSTALL_DT, I.CNT AS INSTALLS, ROUND(CAST(R.CNT AS REAL) / I.CNT, 2) AS DAY1_RETENTION FROM INS AS I JOIN RET AS R ON I.INSTALL_DATE = R.INSTALL_DATE;

/*
Prediction Result:
('1973-03-12', 1, 1.0)
*/