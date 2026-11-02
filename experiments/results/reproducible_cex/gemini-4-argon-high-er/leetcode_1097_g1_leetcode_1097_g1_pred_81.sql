-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 2015, 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(2015, 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT INSTALL_DT, COUNT(T.PLAYER_ID) AS INSTALLS, COALESCE(COUNT(V.EVENT_DATE), 0) AS RETS FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) AS T LEFT JOIN (SELECT PLAYER_ID, EVENT_DATE FROM ACTIVITY) AS V ON T.PLAYER_ID = V.PLAYER_ID AND INSTALL_DT = V.EVENT_DATE - 1 GROUP BY INSTALL_DT) SELECT INSTALL_DT, INSTALLS, ROUND((CAST(RETS AS REAL) / INSTALLS), 2) AS DAY1_RETENTION FROM CTE;

/*
Prediction Result:
(2015, 1, 1.0)
*/