-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 3, 1), (3, '2023-01-01', 3, 0), (-1, '2023-01-01', 0, 2), (3, '2023-01-02', 1, 1), (-1, '2023-01-02', 1, NULL), (-1000, '2026-02-19', 2, 2), (-1000, '2025-06-16', NULL, 2), (1, '2023-01-01', 3, 0), (-1000, '2025-02-19', 2, 2), (1, '2023-01-02', NULL, 3), (-1000, '2026-07-25', 3, 1), (-1000, '2026-05-25', 0, 2), (-1000, '2025-10-11', 3, NULL), (0, '2023-01-01', NULL, 2), (-1000, '2025-10-18', 1, 0), (0, '2023-01-02', 1, 1), (-1000, '2024-11-24', NULL, 3), (2, '2023-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT D0.PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS D0 CROSS JOIN ACTIVITY AS D1 WHERE ((D1.EVENT_DATE - D0.EVENT_DATE) = 1) AND (D1.PLAYER_ID = D0.PLAYER_ID);

/*
Prediction Result:
(0.17,)
*/