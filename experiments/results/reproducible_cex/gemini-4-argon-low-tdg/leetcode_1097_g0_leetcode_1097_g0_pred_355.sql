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
WITH INSTALL_DT AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS DT FROM ACTIVITY GROUP BY PLAYER_ID) SELECT I.DT AS INSTALL_DT, COUNT(I.PLAYER_ID) AS INSTALLS, ROUND(COALESCE(CAST(COUNT(A.PLAYER_ID) AS REAL) / COUNT(I.PLAYER_ID), 0), 2) AS DAY1_RETENTION FROM INSTALL_DT AS I LEFT JOIN ACTIVITY AS A ON I.PLAYER_ID = A.PLAYER_ID AND I.DT = DATE(A.EVENT_DATE, '-1 day') GROUP BY INSTALL_DT ORDER BY INSTALL_DT, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
(100, 3, 0.0)
*/