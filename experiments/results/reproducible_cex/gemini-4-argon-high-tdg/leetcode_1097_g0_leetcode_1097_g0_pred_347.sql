-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200101, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200102, 10, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200105, 10, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200101, 20, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200103, 20, 4);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20200101, 30, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200110, 40, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200111, 40, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 20200110, 50, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 20200111, 50, 8);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, 20200110, 60, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (7, 20200120, 70, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (7, 20200122, 70, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (8, 20200120, 80, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
(20200101, 3, 0.33)
(20200110, 3, 0.67)
(20200120, 2, 0.0)
*/

-- Prediction Query
WITH PLAYER_INSTALL_DATE AS (SELECT A.PLAYER_ID, MIN(A.EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY AS A GROUP BY A.PLAYER_ID), PLAYERS_SAME_INSTALL_DATE AS (SELECT PID.INSTALL_DATE, COUNT(DISTINCT PID.PLAYER_ID) AS TOTAL FROM PLAYER_INSTALL_DATE AS PID GROUP BY PID.INSTALL_DATE), PLAYERS_RETURN_DAY_AFTER AS (SELECT PID.INSTALL_DATE, COUNT(DISTINCT A.PLAYER_ID) AS RETURNED FROM ACTIVITY AS A JOIN PLAYER_INSTALL_DATE AS PID ON A.PLAYER_ID = PID.PLAYER_ID WHERE DATE(A.EVENT_DATE, '-1 day') = PID.INSTALL_DATE GROUP BY A.EVENT_DATE) SELECT PSID.INSTALL_DATE AS INSTALL_DT, PSID.TOTAL AS INSTALLS, COALESCE(ROUND(CAST(PRDA.RETURNED AS REAL) / PSID.TOTAL, 2), 0) AS DAY1_RETENTION FROM PLAYERS_SAME_INSTALL_DATE AS PSID LEFT JOIN PLAYERS_RETURN_DAY_AFTER AS PRDA ON PSID.INSTALL_DATE = PRDA.INSTALL_DATE;

/*
Prediction Result:
(20200101, 3, 0)
(20200110, 3, 0)
(20200120, 2, 0)
*/