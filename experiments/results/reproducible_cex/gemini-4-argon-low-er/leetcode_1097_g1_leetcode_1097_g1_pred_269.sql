-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-02', 10, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 1, 0.0)
*/

-- Prediction Query
WITH FIRST_LOG AS (SELECT MIN(EVENT_DATE) AS INSTALL_DT, PLAYER_ID FROM ACTIVITY GROUP BY 2) SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(CAST(COALESCE(COUNT(RETENTION_DT), 0) AS REAL) / COUNT(PLAYER_ID), 2) AS DAY1_RETENTION FROM (SELECT F.PLAYER_ID, F.INSTALL_DT, A.EVENT_DATE AS RETENTION_DT FROM FIRST_LOG AS F LEFT JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(F.INSTALL_DT)) AS INTEGER) = 1) AS SUB GROUP BY 1;

/*
Prediction Result:
('2023-01-01', 1, 1.0)
*/