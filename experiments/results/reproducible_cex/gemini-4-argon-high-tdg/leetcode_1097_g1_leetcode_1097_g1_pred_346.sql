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
WITH PLAYER_INSTALL_DATE AS (SELECT A.PLAYER_ID, MIN(A.EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY AS A GROUP BY A.PLAYER_ID), PLAYERS_SAME_INSTALL_DATE AS (SELECT PID.INSTALL_DATE, COUNT(DISTINCT PID.PLAYER_ID) AS TOTAL FROM PLAYER_INSTALL_DATE AS PID GROUP BY PID.INSTALL_DATE), PLAYERS_RETURN_DAY_AFTER AS (SELECT PID.INSTALL_DATE, COUNT(DISTINCT A.PLAYER_ID) AS RETURNED FROM ACTIVITY AS A JOIN PLAYER_INSTALL_DATE AS PID ON A.PLAYER_ID = PID.PLAYER_ID WHERE DATE(A.EVENT_DATE, '-1 day') = PID.INSTALL_DATE GROUP BY A.EVENT_DATE) SELECT PSID.INSTALL_DATE AS INSTALL_DT, PSID.TOTAL AS INSTALLS, COALESCE(ROUND(CAST(PRDA.RETURNED AS REAL) / PSID.TOTAL, 2), 0) AS DAY1_RETENTION FROM PLAYERS_SAME_INSTALL_DATE AS PSID LEFT JOIN PLAYERS_RETURN_DAY_AFTER AS PRDA ON PSID.INSTALL_DATE = PRDA.INSTALL_DATE;

/*
Prediction Result:
(20200101, 3, 0)
(20200110, 3, 0)
*/