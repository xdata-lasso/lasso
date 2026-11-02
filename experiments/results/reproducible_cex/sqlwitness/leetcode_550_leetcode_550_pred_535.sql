-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', 2, NULL), (-1, '2023-01-02', 0, 1), (0, '2023-01-01', 0, 1), (0, '2023-01-02', 3, 3), (2, '2023-01-01', NULL, 3), (2, '2023-01-02', 1, 0), (-1000, '2025-06-16', 0, 1), (-1000, '2026-07-25', -1, 0), (-1000, '2024-07-05', 2, 2), (-1000, '2025-10-11', 2, 2), (-1000, '2025-10-18', 3, NULL), (-1000, '2026-02-19', 1, 0), (1, '2023-01-01', -1, 0), (-1000, '2026-05-03', 2, 1), (1, '2023-01-02', 3, NULL), (3, '2023-01-01', 2, 2), (3, '2023-01-02', 3, 3), (-1000, '2025-02-19', 1, NULL), (-1000, '2026-07-07', -1, 0), (-1000, '2026-05-25', NULL, NULL), (-1000, '2025-04-11', 0, 3), (-1000, '2024-11-24', 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(CASE WHEN T1.EVENT_DATE - T2.FIRST_LOGIN = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT T2.PLAYER_ID), 2) AS FRACTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS T2 JOIN ACTIVITY AS T1 ON T1.PLAYER_ID = T2.PLAYER_ID;

/*
Prediction Result:
(0.83,)
*/