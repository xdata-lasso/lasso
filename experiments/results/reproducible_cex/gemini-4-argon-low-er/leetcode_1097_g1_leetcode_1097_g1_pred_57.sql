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
WITH INSTALL_DT AS (SELECT MIN(EVENT_DATE) AS INSTALL_DT, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID), INSTALL_NUM AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM INSTALL_DT GROUP BY INSTALL_DT), RETENTION_NUM AS (SELECT COUNT(DISTINCT A.PLAYER_ID) AS RETENTION_NUM, I.INSTALL_DT AS INSTALL_DT FROM INSTALL_DT AS I LEFT JOIN ACTIVITY AS A ON CAST((JULIANDAY(I.INSTALL_DT) - JULIANDAY(A.EVENT_DATE)) AS INTEGER) = -1 AND I.PLAYER_ID = A.PLAYER_ID GROUP BY I.INSTALL_DT) SELECT I.INSTALL_DT AS INSTALL_DT, I.INSTALLS AS INSTALLS, ROUND(CAST(COALESCE(R.RETENTION_NUM, 0) AS REAL) / I.INSTALLS, 2) AS DAY1_RETENTION FROM INSTALL_NUM AS I LEFT JOIN RETENTION_NUM AS R ON I.INSTALL_DT = R.INSTALL_DT;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/