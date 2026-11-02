-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', NULL, 2), (3, '2023-01-01', 2, 1), (-1, '2023-01-01', 2, 1), (3, '2023-01-02', 1, 0), (-1, '2023-01-02', -1, 1), (1, '2023-01-01', 1, 3), (1, '2023-01-02', NULL, 1), (-1000, '2026-05-25', 3, 2), (0, '2023-01-01', 0, NULL), (0, '2023-01-02', -1, 3), (2, '2023-01-01', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST((SELECT COUNT(*) FROM (SELECT PLAYER_ID, EVENT_DATE FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, DATE(MIN(EVENT_DATE), '1 DAY') FROM ACTIVITY GROUP BY PLAYER_ID)) AS T) AS REAL) / COUNT(DISTINCT (PLAYER_ID)), 2) AS FRACTION FROM ACTIVITY;

/*
Prediction Result:
(0.83,)
*/