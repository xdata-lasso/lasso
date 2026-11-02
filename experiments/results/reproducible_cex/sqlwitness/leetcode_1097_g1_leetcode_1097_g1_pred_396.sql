-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', NULL, 3), (2, '2023-01-01', NULL, 0), (0, '2023-01-02', 2, 3), (0, '2023-01-01', -1, 3), (3, '2023-01-01', 3, 1), (-1, '2023-01-01', NULL, 2), (1, '2023-01-02', 0, 1), (1, '2023-01-01', 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 5, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, EVENT_DATE, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS EVENT_RANK, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_EVENT_DATE, CAST((JULIANDAY(LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE)) - JULIANDAY(EVENT_DATE)) AS INTEGER) AS DATE_DIFFRENCE FROM ACTIVITY), CTE_2 AS (SELECT EVENT_DATE AS INSTALL_DATE, COUNT(DISTINCT PLAYER_ID) AS NUM_INSTALL, COUNT(DISTINCT CASE WHEN DATE_DIFFRENCE = 1 THEN PLAYER_ID ELSE NULL END) AS RENTENTION FROM CTE WHERE EVENT_RANK = 1 GROUP BY 1) SELECT INSTALL_DATE AS INSTALL_DT, NUM_INSTALL AS INSTALLS, ROUND((CAST(RENTENTION * 1.0 AS REAL) / NUM_INSTALL), 2) AS DAY1_RETENTION FROM CTE_2 WHERE NUM_INSTALL <> 0;

/*
Prediction Result:
('2023-01-01', 5, 0.6)
*/