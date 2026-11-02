-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200101, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200102, 10, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200101, 20, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200102, 20, 4);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20200101, 30, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200110, 40, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200111, 40, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 20200110, 50, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, 20200110, 60, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(20200101, 3, 0.67)
(20200110, 3, 0.33)
*/

-- Prediction Query
WITH INSTALL_DATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), INSTALL_CNT AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM INSTALL_DATE GROUP BY INSTALL_DT), RETENTION AS (SELECT A1.PLAYER_ID, A1.INSTALL_DT FROM INSTALL_DATE AS A1 INNER JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND CAST((JULIANDAY(A1.INSTALL_DT) - JULIANDAY(A2.EVENT_DATE)) AS INTEGER) = -1), RETENTION_CNT AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS RETENTION FROM RETENTION GROUP BY INSTALL_DT) SELECT I.INSTALL_DT, INSTALLS, CASE WHEN RETENTION IS NULL THEN 0.00 ELSE ROUND(CAST(RETENTION AS REAL) / INSTALLS, 2) END AS DAY1_RETENTION FROM INSTALL_CNT AS I LEFT JOIN RETENTION_CNT AS R ON I.INSTALL_DT = R.INSTALL_DT ORDER BY I.INSTALL_DT, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
(20200101, 3, 0.0)
(20200110, 3, 0.0)
*/