-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 100, 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 101, 1, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 100, 2, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 100, 3, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 102, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
(100, 3, 0.33)
*/

-- Prediction Query
WITH RK AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS F_DATE FROM ACTIVITY GROUP BY PLAYER_ID), MPP AS (SELECT PLAYER_ID, F_DATE, DATE(F_DATE, '1 DAY') AS S_DATE FROM RK), FP AS (SELECT A.PLAYER_ID, A.F_DATE, A.S_DATE, CASE WHEN B.EVENT_DATE IS NULL THEN 0 ELSE 1 END AS ACT FROM MPP AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.S_DATE = B.EVENT_DATE) SELECT F_DATE AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(ACT) AS REAL) / COUNT(ACT), 2) AS DAY1_RETENTION FROM FP GROUP BY INSTALL_DT;

/*
Prediction Result:
(100, 3, 0.0)
*/