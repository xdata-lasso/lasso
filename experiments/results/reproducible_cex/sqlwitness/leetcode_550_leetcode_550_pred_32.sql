-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 1, 3), (3, '2023-01-01', 3, 3), (-1, '2023-01-01', 3, NULL), (3, '2023-01-02', 2, 0), (-1, '2023-01-02', 0, 0), (-1000, '2025-06-16', 3, NULL), (1, '2023-01-01', -1, 0), (-1000, '2025-02-19', 3, 2), (1, '2023-01-02', 2, 0), (-1000, '2026-07-25', -1, 1), (-1000, '2026-05-25', -1, 2), (-1000, '2025-10-11', -1, 0), (0, '2023-01-01', -1, 2), (0, '2023-01-02', 3, 2), (-1000, '2024-11-24', 0, NULL), (2, '2023-01-01', -1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT (T.PLAYER_ID)) AS REAL) / (SELECT COUNT(DISTINCT (PLAYER_ID)) FROM ACTIVITY), 2) AS FRACTION FROM (SELECT PLAYER_ID, (EVENT_DATE - LAG(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE)) AS DIF, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NUM FROM ACTIVITY) AS T WHERE DIF = 1 AND NUM = 2;

/*
Prediction Result:
(0.17,)
*/