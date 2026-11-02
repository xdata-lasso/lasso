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
WITH T1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), T2 AS (SELECT *, DATE(INSTALL_DT, '1 DAY') AS DAY_AFTER FROM T1), T3 AS (SELECT T2.INSTALL_DT, COUNT(T2.PLAYER_ID) AS NUM_RETURN FROM ACTIVITY AS A INNER JOIN T2 ON A.PLAYER_ID = T2.PLAYER_ID AND A.EVENT_DATE = T2.DAY_AFTER GROUP BY T2.INSTALL_DT) SELECT TEMP.INSTALL_DT, INSTALLS, COALESCE(ROUND(CAST(NUM_RETURN AS REAL) / INSTALLS, 2), 0) AS DAY1_RETENTION FROM (SELECT INSTALL_DT, COUNT(*) AS INSTALLS FROM T1 GROUP BY INSTALL_DT) AS TEMP LEFT JOIN T3 ON TEMP.INSTALL_DT = T3.INSTALL_DT;

/*
Prediction Result:
(20200101, 3, 0)
(20200110, 3, 0)
(20200120, 2, 0)
*/