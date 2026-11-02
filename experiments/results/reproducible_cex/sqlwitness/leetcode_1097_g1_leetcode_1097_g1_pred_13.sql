-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 3, 0), (1, '2023-01-01', 3, 3), (3, '2023-01-02', 3, NULL), (3, '2023-01-01', NULL, 2), (0, '2023-01-01', 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 3, 0.0)
('2023-01-02', 1, 0.0)
*/

-- Prediction Query
SELECT INSTALL_DT, COUNT(DISTINCT A1.PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(INSTALL_DT)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID GROUP BY INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 3, 0.33)
('2023-01-02', 1, 0.0)
*/