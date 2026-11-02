-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-02', 1, 2), (0, '2023-01-02', 1, 0), (1, '2023-01-01', 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 1, 0.0)
('2023-01-02', 1, 0.0)
*/

-- Prediction Query
WITH FIRST_LOGIN_CTE AS (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY 1) SELECT INSTALL_DT, COUNT(DISTINCT F.PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(F.INSTALL_DT)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT F.PLAYER_ID), 2) AS DAY1_RETENTION FROM FIRST_LOGIN_CTE AS F JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID GROUP BY 1;

/*
Prediction Result:
('2023-01-01', 1, 1.0)
('2023-01-02', 1, 0.0)
*/