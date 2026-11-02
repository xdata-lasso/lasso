-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, '0998-01-11', 0, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (0, '0998-01-12', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('0998-01-11', 1, 0.0)
*/

-- Prediction Query
WITH INSTALL_DETAILS AS (SELECT MIN(EVENT_DATE) AS INSTALL_DT, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID) SELECT INSTALL_DT, SUM(INSTALLS) AS INSTALLS, ROUND(CAST(SUM(RETENTION) AS REAL) / SUM(INSTALLS), 2) AS DAY1_RETENTION FROM (SELECT INSTALL_DT, 1 AS INSTALLS, CASE WHEN A.PLAYER_ID THEN 1 ELSE 0 END AS RETENTION FROM INSTALL_DETAILS AS I LEFT JOIN ACTIVITY AS A ON I.PLAYER_ID = A.PLAYER_ID AND DATE(I.INSTALL_DT, '1 DAY') = A.EVENT_DATE) AS T GROUP BY INSTALL_DT;

/*
Prediction Result:
('0998-01-11', 1, 0.0)
*/