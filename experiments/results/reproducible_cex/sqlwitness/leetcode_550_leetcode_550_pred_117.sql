-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', 2, NULL), (-1, '2023-01-02', 2, 1), (0, '2023-01-01', -1, 3), (0, '2023-01-02', NULL, 0), (2, '2023-01-01', NULL, 1), (2, '2023-01-02', NULL, 1), (-1000, '2025-06-16', 2, 2), (-1000, '2026-07-25', 0, 2), (-1000, '2024-07-05', NULL, 2), (-1000, '2025-10-11', 2, 1), (-1000, '2025-10-18', 1, 0), (-1000, '2026-02-19', -1, 2), (1, '2023-01-01', 0, 2), (-1000, '2026-05-03', 0, 3), (1, '2023-01-02', 1, 1), (3, '2023-01-01', -1, 2), (3, '2023-01-02', 3, 1), (-1000, '2025-02-19', -1, NULL), (-1000, '2026-07-07', 0, 0), (-1000, '2026-05-25', 1, 3), (-1000, '2025-04-11', 0, 0), (-1000, '2024-11-24', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND((CAST(COUNT(F.PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY)), 2) AS FRACTION FROM ACTIVITY AS F JOIN ACTIVITY AS S ON F.PLAYER_ID = S.PLAYER_ID AND (S.EVENT_DATE - F.EVENT_DATE) = 1 WHERE (F.PLAYER_ID, F.EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Prediction Result:
(0.83,)
*/