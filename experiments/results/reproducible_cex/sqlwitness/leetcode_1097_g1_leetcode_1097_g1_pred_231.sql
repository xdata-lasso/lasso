-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-01', 1, 1), (1, '2023-01-01', 2, 1), (2, '2023-01-02', 0, 3), (2, '2023-01-01', 1, 0), (0, '2023-01-01', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 4, 0.0)
*/

-- Prediction Query
WITH T1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), T2 AS (SELECT T0.PLAYER_ID, T0.INSTALL_DT, CASE WHEN NOT A.PLAYER_ID IS NULL THEN A.PLAYER_ID ELSE NULL END AS RETAINED_PLAYER_ID FROM (SELECT PLAYER_ID, INSTALL_DT, DATE(INSTALL_DT, '1 DAY') AS NEXT_DATE FROM T1) AS T0 LEFT JOIN ACTIVITY AS A ON T0.PLAYER_ID = A.PLAYER_ID AND T0.NEXT_DATE = A.EVENT_DATE) SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(DISTINCT RETAINED_PLAYER_ID) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS DAY1_RETENTION FROM T2 GROUP BY INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 4, 0.25)
*/