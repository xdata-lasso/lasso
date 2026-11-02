-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Using integer representations for dates due to SQLite arithmetic (FIRST_LOGIN + 1 = EVENT_DATE) in the Reference Query.
-- Tests basic Day 1 retention (50% retention), multiple logins for the same player (testing COUNT(DISTINCT)), and multiple install dates.
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 100, 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 101, 1, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 105, 1, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 100, 2, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 102, 2, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 101, 3, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 102, 3, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
(100, 2, 0.5)
(101, 1, 1.0)
*/

-- Prediction Query
WITH INSTALLS_A AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) SELECT A.INSTALL_DT, COUNT(DISTINCT A.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(DISTINCT B.PLAYER_ID) AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS DAY1_RETENTION FROM INSTALLS_A AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE = DATE(A.INSTALL_DT, '1 DAY') GROUP BY A.INSTALL_DT;

/*
Prediction Result:
(100, 2, 0.0)
(101, 1, 0.0)
*/