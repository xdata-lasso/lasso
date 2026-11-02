-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH INSTALL_DATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), D2 AS (SELECT I.PLAYER_ID, I.INSTALL_DATE, MAX(IIF(NOT D2.EVENT_DATE IS NULL, 1, 0)) AS D2_ACTIVE FROM INSTALL_DATE AS I LEFT JOIN ACTIVITY AS D2 ON I.PLAYER_ID = D2.PLAYER_ID AND DATE(I.INSTALL_DATE, '+1 day') = D2.EVENT_DATE GROUP BY 1, 2) SELECT INSTALL_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(AVG(D2_ACTIVE), 2) AS DAY1_RETENTION FROM D2 GROUP BY 1;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/