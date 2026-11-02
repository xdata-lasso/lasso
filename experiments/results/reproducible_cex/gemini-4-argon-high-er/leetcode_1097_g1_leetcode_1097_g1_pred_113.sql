-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '20200101', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '20200102', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(20200101, 1, 1.0)
*/

-- Prediction Query
SELECT T1.INSTALL_DT, COUNT(DISTINCT T1.PLAYER_ID) AS INSTALLS, ROUND(AVG(CASE WHEN NOT A1.GAMES_PLAYED IS NULL THEN 1 ELSE 0 END), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) AS T1 LEFT JOIN ACTIVITY AS A1 ON T1.PLAYER_ID = A1.PLAYER_ID AND T1.INSTALL_DT + 1 = A1.EVENT_DATE GROUP BY T1.INSTALL_DT;

/*
Prediction Result:
(20200101, 1, 0.0)
*/