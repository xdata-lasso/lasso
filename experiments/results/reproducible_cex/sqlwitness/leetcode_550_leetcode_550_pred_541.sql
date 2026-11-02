-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 2, 2), (3, '2023-01-01', NULL, 2), (-1, '2023-01-01', 1, 0), (3, '2023-01-02', -1, NULL), (-1, '2023-01-02', -1, 2), (-1000, '2025-06-16', 0, 2), (1, '2023-01-01', 0, NULL), (1, '2023-01-02', 3, 0), (-1000, '2026-07-25', NULL, 2), (-1000, '2026-05-25', 2, 2), (0, '2023-01-01', -1, NULL), (0, '2023-01-02', 2, 3), (-1000, '2024-11-24', 0, 0), (2, '2023-01-01', 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(CASE WHEN CONSECUTIVE_DAY_CHECK = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM (SELECT DISTINCT PLAYER_ID, FIRST_VALUE(CONSECUTIVE_DAYS) OVER (PARTITION BY PLAYER_ID) AS CONSECUTIVE_DAY_CHECK FROM (SELECT PLAYER_ID, CASE WHEN LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) - EVENT_DATE = 1 THEN 1 ELSE 0 END AS CONSECUTIVE_DAYS FROM ACTIVITY) AS TEMP) AS T;

/*
Prediction Result:
(0.17,)
*/