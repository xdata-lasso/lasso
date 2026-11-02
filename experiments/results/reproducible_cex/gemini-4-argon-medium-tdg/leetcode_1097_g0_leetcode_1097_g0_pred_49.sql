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
WITH FIRST_LOGIN AS (SELECT EVENT_DATE, PLAYER_ID FROM (SELECT EVENT_DATE, PLAYER_ID, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS A WHERE A.RNK = 1), ONE_PLUS_DAYS AS (SELECT F.PLAYER_ID, F.EVENT_DATE AS FIRST_DATE, A.EVENT_DATE AS SECOND_DATE FROM FIRST_LOGIN AS F LEFT JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND F.EVENT_DATE = DATE(A.EVENT_DATE, '-1 DAY')), CASES AS (SELECT FIRST_DATE, SECOND_DATE, CASE WHEN NOT SECOND_DATE IS NULL THEN 1 ELSE 0 END AS CNT1 FROM ONE_PLUS_DAYS) SELECT FIRST_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(CNT1) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM CASES GROUP BY FIRST_DATE;

/*
Prediction Result:
(100, 2, 0.0)
(101, 1, 0.0)
*/