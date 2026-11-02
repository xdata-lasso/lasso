-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 3, NULL), (2, '2023-01-01', 2, 2), (0, '2023-01-01', 3, 0), (3, '2023-01-01', 3, 3), (1, '2023-01-02', NULL, NULL), (1, '2023-01-01', 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 4, 0.0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY AS A GROUP BY PLAYER_ID) SELECT A.INSTALL_DT, COUNT(A.INSTALL_DT) AS INSTALLS, ROUND(CAST(COUNT(B.EVENT_DATE) AS REAL) / COUNT(A.INSTALL_DT), 2) AS DAY1_RETENTION FROM CTE1 AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.INSTALL_DT = DATE(B.EVENT_DATE, '-1 day') GROUP BY A.INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 4, 0.5)
*/