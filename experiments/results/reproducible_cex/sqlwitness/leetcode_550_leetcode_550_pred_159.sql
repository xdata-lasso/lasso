-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 3, NULL), (3, '2023-01-01', 0, NULL), (-1, '2023-01-01', NULL, 0), (3, '2023-01-02', NULL, 0), (-1, '2023-01-02', 0, NULL), (-1000, '2025-06-16', 1, 2), (1, '2023-01-01', 1, NULL), (1, '2023-01-02', -1, 3), (-1000, '2026-07-25', 2, 1), (-1000, '2026-05-25', 1, 1), (0, '2023-01-01', 1, 3), (0, '2023-01-02', -1, 2), (2, '2023-01-01', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT CASE WHEN DATE_RANK = 1 AND DAYS_SINCE_FIRST_LOGIN = -1 THEN PLAYER_ID END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS DATE_RANK, EVENT_DATE - LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DAYS_SINCE_FIRST_LOGIN FROM ACTIVITY) AS A;

/*
Prediction Result:
(0.17,)
*/