-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', -1, 2), (-1, '2023-01-02', 1, 1), (0, '2023-01-01', 0, 0), (0, '2023-01-02', 2, 3), (2, '2023-01-01', -1, 2), (2, '2023-01-02', 3, 1), (-1000, '2025-06-16', 3, 3), (-1000, '2026-07-25', -1, 2), (-1000, '2025-10-11', 0, 3), (-1000, '2025-10-18', 3, 0), (-1000, '2026-02-19', 3, 1), (1, '2023-01-01', 2, 1), (-1000, '2026-05-03', -1, 2), (1, '2023-01-02', 2, NULL), (3, '2023-01-01', 0, 0), (3, '2023-01-02', NULL, 2), (-1000, '2025-02-19', 3, NULL), (-1000, '2026-05-25', 0, 1), (-1000, '2024-11-24', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT COUNT(*) AS NUM FROM (SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RNK, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID) AS LD0 FROM ACTIVITY) AS TBL WHERE LD0 - EVENT_DATE = 1 AND RNK = 1) SELECT ROUND(CAST(NUM AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM CTE1;

/*
Prediction Result:
(0.17,)
*/