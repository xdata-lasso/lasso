-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', 1, NULL), (1, '2023-01-02', 1, 0), (-1000, '2026-07-25', NULL, 1), (-1000, '2026-05-25', NULL, NULL), (0, '2023-01-01', NULL, 1), (0, '2023-01-02', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(-1000, None)
(0, None)
(1, 1)
*/

-- Prediction Query
SELECT DISTINCT PLAYER_ID, FIRST_VALUE(DEVICE_ID) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DEVICE_ID FROM ACTIVITY ORDER BY EVENT_DATE, PLAYER_ID NULLS LAST, DEVICE_ID NULLS LAST;

/*
Prediction Result:
(0, None)
(1, 1)
(-1000, None)
*/