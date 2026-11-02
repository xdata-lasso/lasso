-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1000, '2025-06-16', 0, 0), (1, '2023-01-01', 0, 0), (-1000, '2025-02-19', 1, 1), (1, '2023-01-02', NULL, 1), (-1000, '2026-07-25', 1, NULL), (-1000, '2026-05-25', NULL, NULL), (0, '2023-01-01', 0, 0), (0, '2023-01-02', 1, 1), (-1000, '2024-11-24', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(-1000, 0)
(0, 0)
(1, 0)
*/

-- Prediction Query
SELECT DISTINCT PLAYER_ID, FIRST_VALUE(DEVICE_ID) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DEVICE_ID FROM ACTIVITY ORDER BY EVENT_DATE, PLAYER_ID NULLS LAST, DEVICE_ID NULLS LAST;

/*
Prediction Result:
(0, 0)
(1, 0)
(-1000, 0)
*/