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
SELECT T.EVENT_DATE AS INSTALL_DT, COUNT(T.PLAYER_ID) AS INSTALLS, CAST(CAST(SUM(CASE WHEN T.DATE_ONE IS NULL THEN 0 ELSE 1 END) AS REAL) / COUNT(T.PLAYER_ID) AS REAL(10, 2)) AS DAY1_RETENTION FROM (SELECT A.PLAYER_ID, A.EVENT_DATE, B.EVENT_DATE AS DATE_ONE FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS A LEFT JOIN (SELECT PLAYER_ID, EVENT_DATE FROM ACTIVITY) AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE = A.EVENT_DATE + 1) AS T GROUP BY T.EVENT_DATE;

/*
Prediction Result:
(200, 3, 0.3333333333333333)
(205, 1, 0.0)
(210, 3, 0.6666666666666666)
*/