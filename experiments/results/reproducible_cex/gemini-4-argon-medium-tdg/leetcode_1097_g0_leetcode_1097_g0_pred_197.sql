-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests rounding precision (1/3 = 0.33, 2/3 = 0.67) and 0% retention.
-- Also tests when a player's second login is the install date of another player (cross-player join mutations).
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 200, 10, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 201, 10, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 200, 20, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 205, 20, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 200, 30, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 205, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 210, 40, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 211, 40, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, 210, 50, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, 211, 50, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (7, 210, 60, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND((CAST(SUM(CASE WHEN (A1.FIRST_LOGIN + 1) = A2.EVENT_DATE THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID)), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.FIRST_LOGIN;

/*
Gold Result:
(200, 3, 0.33)
(205, 1, 0.0)
(210, 3, 0.67)
*/

-- Prediction Query
WITH TMP1 AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS ROW_INDEX FROM ACTIVITY), TMP2 AS (SELECT EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM TMP1 WHERE ROW_INDEX = 1 GROUP BY 1), TMP3 AS (SELECT T2.EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT T1.PLAYER_ID) AS DAY1_INSTALLS FROM (SELECT * FROM TMP1 WHERE ROW_INDEX = 2) AS T1 LEFT JOIN (SELECT * FROM TMP1 WHERE ROW_INDEX = 1) AS T2 ON T1.PLAYER_ID = T2.PLAYER_ID AND CAST((JULIANDAY(T1.EVENT_DATE) - JULIANDAY(T2.EVENT_DATE)) AS INTEGER) = 1 GROUP BY 1) SELECT TMP2.INSTALL_DT, TMP2.INSTALLS, CAST(COALESCE(CAST(TMP3.DAY1_INSTALLS * 1.0 AS REAL) / TMP2.INSTALLS, 0) AS REAL(10, 2)) AS DAY1_RETENTION FROM TMP2 LEFT JOIN TMP3 ON TMP2.INSTALL_DT = TMP3.INSTALL_DT;

/*
Prediction Result:
(200, 3, 0.3333333333333333)
(205, 1, 0.0)
(210, 3, 0.6666666666666666)
*/