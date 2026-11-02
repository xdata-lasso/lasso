-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', NULL, NULL), (-1, '2023-01-02', 0, NULL), (-1000, '2026-03-26', -1, 1), (0, '2023-01-01', -1, NULL), (0, '2023-01-02', NULL, NULL), (2, '2023-01-01', 1, NULL), (2, '2023-01-02', -1, NULL), (-1000, '2025-06-16', -1, 1), (-1000, '2026-07-25', -1, 2), (-1000, '2024-07-05', 1, 0), (-1000, '2025-10-11', 2, 2), (-1000, '2024-08-08', NULL, 0), (-1000, '2025-10-18', 1, 2), (-1000, '2026-02-19', NULL, 1), (-1000, '2026-03-21', 1, NULL), (1, '2023-01-01', 2, 0), (-1000, '2026-05-03', NULL, 3), (1, '2023-01-02', -1, 3), (3, '2023-01-01', 2, NULL), (3, '2023-01-02', -1, 1), (-1000, '2025-02-19', 3, NULL), (-1000, '2026-07-07', 0, 2), (-1000, '2026-05-25', 1, 3), (-1000, '2025-04-11', 3, 0), (-1000, '2024-11-24', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT A.PLAYER_ID, MIN(A.EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY AS A GROUP BY 1), LEAD_DATE AS (SELECT F.PLAYER_ID, F.FIRST_LOGIN, A.EVENT_DATE - F.FIRST_LOGIN AS EVENT_DATEDIFF FROM FIRST_LOGIN AS F LEFT JOIN ACTIVITY AS A ON A.PLAYER_ID = F.PLAYER_ID AND A.EVENT_DATE <> F.FIRST_LOGIN) SELECT ROUND(CAST(COUNT(DISTINCT CASE WHEN EVENT_DATEDIFF = 1 THEN PLAYER_ID END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM LEAD_DATE;

/*
Prediction Result:
(0.17,)
*/