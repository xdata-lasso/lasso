-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', NULL, 2), (3, '2023-01-01', 0, 0), (-1, '2023-01-01', NULL, 1), (3, '2023-01-02', 0, 3), (-1, '2023-01-02', 1, 1), (-1000, '2025-06-16', 3, 1), (1, '2023-01-01', 1, 1), (1, '2023-01-02', 0, 1), (-1000, '2026-07-25', NULL, 2), (-1000, '2026-05-25', 3, 2), (0, '2023-01-01', NULL, 3), (0, '2023-01-02', NULL, 3), (-1000, '2024-11-24', 0, 1), (2, '2023-01-01', NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH BASE AS (SELECT PLAYER_ID, EVENT_DATE, EVENT_DATE - LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_EVENT, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS LOGIN_NUM FROM ACTIVITY) SELECT ROUND(CAST(SUM(CASE NEXT_EVENT WHEN -1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM BASE WHERE LOGIN_NUM = 1;

/*
Prediction Result:
(0.17,)
*/