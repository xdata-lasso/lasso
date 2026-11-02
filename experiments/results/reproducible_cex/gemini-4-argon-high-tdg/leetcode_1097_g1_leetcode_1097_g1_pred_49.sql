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
WITH FIST_LOG AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY 1) SELECT SDATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN NOT NDATE IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM (SELECT F.PLAYER_ID, F.EVENT_DATE AS SDATE, A.EVENT_DATE AS NDATE FROM FIST_LOG AS F LEFT JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND CAST((JULIANDAY(F.EVENT_DATE) - JULIANDAY(A.EVENT_DATE)) AS INTEGER) = -1) AS T2 GROUP BY SDATE ORDER BY SDATE, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
(20200101, 3, 0.0)
(20200110, 3, 0.0)
*/