-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 1, 0.0)
*/

-- Prediction Query
WITH TBL_INSTALL AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) AS TMP_INSTALL GROUP BY INSTALL_DT), TBL_DAY1_RETENTION AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM (SELECT A1.INSTALL_DT, A1.PLAYER_ID FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.PLAYER_ID = A2.PLAYER_ID AND CAST((JULIANDAY(A2.EVENT_DATE) - JULIANDAY(A1.INSTALL_DT)) AS INTEGER) = 1) AS TMP_RET GROUP BY INSTALL_DT) SELECT A1.INSTALL_DT, A1.INSTALLS, ROUND(CAST(COALESCE(A2.INSTALLS, 0) AS REAL) / A1.INSTALLS, 2) AS DAY1_RETENTION FROM TBL_INSTALL AS A1 LEFT JOIN TBL_DAY1_RETENTION AS A2 ON A1.INSTALL_DT = A2.INSTALL_DT;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/