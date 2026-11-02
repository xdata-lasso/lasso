-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2021', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2022-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(2021, 1, 0.0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), CTE2 AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM CTE1 GROUP BY INSTALL_DT), CTE3 AS (SELECT B.INSTALL_DT, A.PLAYER_ID FROM CTE1 AS B LEFT JOIN ACTIVITY AS A ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE - 1 = B.INSTALL_DT WHERE NOT B.INSTALL_DT IS NULL), CTE4 AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS NUM_RETENTION FROM CTE3 GROUP BY INSTALL_DT) SELECT A.INSTALL_DT, A.INSTALLS, ROUND(COALESCE(CAST(B.NUM_RETENTION AS REAL) / A.INSTALLS, 0), 2) AS DAY1_RETENTION FROM CTE2 AS A LEFT JOIN CTE4 AS B ON A.INSTALL_DT = B.INSTALL_DT;

/*
Prediction Result:
(2021, 1, 1.0)
*/