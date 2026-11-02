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
SELECT FIRST_LOGIN AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(COALESCE(AVG(CAST((JULIANDAY(SECOND_LOGIN) - JULIANDAY(FIRST_LOGIN)) AS INTEGER) = 1), 0), 2) AS DAY1_RETENTION FROM (SELECT *, (SELECT MIN(EVENT_DATE) FROM ACTIVITY WHERE PLAYER_ID = TMP.PLAYER_ID AND EVENT_DATE <> TMP.FIRST_LOGIN) AS SECOND_LOGIN FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS TMP) AS TMP2 GROUP BY FIRST_LOGIN;

/*
Prediction Result:
(200, 3, 0.5)
(205, 1, 0.0)
(210, 3, 1.0)
*/