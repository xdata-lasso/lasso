-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 1, 0), (-1000, '2025-06-16', 0, 0), (1, '2023-01-01', NULL, 0), (-1000, '2025-02-19', NULL, 0), (1, '2023-01-02', 0, 0), (-1000, '2026-07-25', NULL, 2), (-1000, '2026-05-25', 1, 0), (-1000, '2025-10-11', 2, 2), (0, '2023-01-01', NULL, 0), (-1000, '2025-10-18', 2, NULL), (0, '2023-01-02', 0, 2), (-1000, '2024-11-24', 2, 0), (2, '2023-01-01', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(-1000, '2024-11-24')
(0, '2023-01-01')
(1, '2023-01-01')
(2, '2023-01-01')
*/

-- Prediction Query
WITH X AS (SELECT PLAYER_ID, EVENT_DATE, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DENSER FROM ACTIVITY) SELECT PLAYER_ID, EVENT_DATE AS FIRST_LOGIN FROM X WHERE DENSER = 1 ORDER BY FIRST_LOGIN, PLAYER_ID NULLS LAST;

/*
Prediction Result:
(0, '2023-01-01')
(1, '2023-01-01')
(2, '2023-01-01')
(-1000, '2024-11-24')
*/