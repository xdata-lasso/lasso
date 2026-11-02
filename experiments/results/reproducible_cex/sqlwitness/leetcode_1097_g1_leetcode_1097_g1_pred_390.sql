-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 1, 0), (3, '2023-01-02', NULL, 0), (-1, '2023-01-02', 2, NULL), (0, '2023-01-01', 0, 0), (-1, '2023-01-01', 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
('2023-01-02', 2, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_LOGIN, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RK FROM ACTIVITY), CTE2 AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS NUM_LOGINS, SUM(CAST((JULIANDAY(NEXT_LOGIN) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1) AS REPEAT_LOGINS FROM CTE WHERE RK = 1 GROUP BY EVENT_DATE) SELECT EVENT_DATE AS INSTALL_DT, NUM_LOGINS AS INSTALLS, COALESCE(ROUND(CAST(REPEAT_LOGINS AS REAL) / NUM_LOGINS, 2), 0) AS DAY1_RETENTION FROM CTE2 GROUP BY EVENT_DATE, INSTALLS, DAY1_RETENTION;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 2, 0)
*/