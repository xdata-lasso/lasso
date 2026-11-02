-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 2020, 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2021-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(2020, 1, 0.0)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID), TEMP AS (SELECT F.PLAYER_ID, FIRST_LOGIN FROM FIRST_LOGIN AS F JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND F.FIRST_LOGIN = A.EVENT_DATE - 1), TEMP1 AS (SELECT FIRST_LOGIN AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM FIRST_LOGIN GROUP BY FIRST_LOGIN), TEMP2 AS (SELECT FIRST_LOGIN AS INSTALL_DT, COUNT(PLAYER_ID) AS NUM_REN FROM TEMP GROUP BY FIRST_LOGIN) SELECT T1.INSTALL_DT, T1.INSTALLS, COALESCE(ROUND(CAST(T2.NUM_REN AS REAL) / T1.INSTALLS, 2), 0) AS DAY1_RETENTION FROM TEMP1 AS T1 LEFT JOIN TEMP2 AS T2 ON T1.INSTALL_DT = T2.INSTALL_DT;

/*
Prediction Result:
(2020, 1, 1.0)
*/