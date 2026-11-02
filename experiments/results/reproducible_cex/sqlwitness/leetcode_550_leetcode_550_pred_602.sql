-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 3, 0), (3, '2023-01-01', 3, 2), (-1, '2023-01-01', 3, NULL), (3, '2023-01-02', -1, 0), (-1, '2023-01-02', 3, NULL), (-1000, '2025-06-16', -1, 2), (1, '2023-01-01', 2, 2), (-1000, '2025-02-19', -1, 2), (1, '2023-01-02', NULL, 2), (-1000, '2026-07-25', 3, 1), (-1000, '2026-05-25', 1, NULL), (0, '2023-01-01', 3, NULL), (0, '2023-01-02', -1, 0), (-1000, '2024-11-24', 2, NULL), (2, '2023-01-01', 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND((CAST(CONS_PLAYERS AS REAL) / TOTAL_PLAYERS), 2) AS FRACTION FROM (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL_PLAYERS, COUNT(DISTINCT CASE WHEN NEXT_DATE - EVENT_DATE = 1 THEN PLAYER_ID ELSE NULL END) AS CONS_PLAYERS FROM (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_DATE FROM (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS ROWNUMS FROM ACTIVITY) AS A WHERE ROWNUMS <= 2) AS B) AS C;

/*
Prediction Result:
(0.17,)
*/