-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', 2, 0), (-1, '2023-01-02', 0, 0), (0, '2023-01-01', 3, 0), (0, '2023-01-02', NULL, NULL), (2, '2023-01-01', 2, 0), (2, '2023-01-02', NULL, 2), (-1000, '2025-06-16', -1, 3), (-1000, '2026-07-25', 0, 3), (-1000, '2025-10-11', 3, 1), (-1000, '2025-10-18', NULL, 0), (-1000, '2026-02-19', 2, 2), (1, '2023-01-01', -1, NULL), (-1000, '2026-05-03', 3, 3), (1, '2023-01-02', 3, 0), (3, '2023-01-01', -1, NULL), (3, '2023-01-02', 2, 2), (-1000, '2025-02-19', 2, 2), (-1000, '2026-07-07', 0, 0), (-1000, '2026-05-25', 1, 2), (-1000, '2024-11-24', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TT AS (SELECT PLAYER_ID, EVENT_DATE - LAG(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS LAGO, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) SELECT ROUND(CAST(COUNT(DISTINCT PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM TT WHERE RNK = 2 AND LAGO = 1;

/*
Prediction Result:
(0.17,)
*/