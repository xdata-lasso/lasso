-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 0, 3), (3, '2023-01-01', 3, 0), (-1, '2023-01-01', 2, 3), (3, '2023-01-02', 0, 0), (-1, '2023-01-02', 0, 0), (-1000, '2025-06-16', -1, 2), (1, '2023-01-01', 2, NULL), (-1000, '2025-02-19', NULL, 2), (1, '2023-01-02', -1, 1), (-1000, '2026-07-25', NULL, 0), (-1000, '2026-05-25', -1, 1), (0, '2023-01-01', 1, 0), (0, '2023-01-02', -1, 2), (-1000, '2024-11-24', -1, 0), (2, '2023-01-01', 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH T AS (SELECT PLAYER_ID, CASE WHEN EVENT_DATE - MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) = 1 THEN 1 ELSE 0 END AS S FROM ACTIVITY) SELECT ROUND(CAST(SUM(T.S) AS REAL) / COUNT(DISTINCT T.PLAYER_ID), 2) AS FRACTION FROM T;

/*
Prediction Result:
(0.33,)
*/