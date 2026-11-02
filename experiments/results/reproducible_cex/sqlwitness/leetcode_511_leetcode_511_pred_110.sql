-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', 1, NULL), (1, '2023-01-02', 1, 0), (-1000, '2026-05-25', 0, 0), (0, '2023-01-01', 1, NULL), (0, '2023-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(-1000, '2026-05-25')
(0, '2023-01-01')
(1, '2023-01-01')
*/

-- Prediction Query
SELECT DISTINCT (PLAYER_ID), MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID ORDER BY EVENT_DATE, (PLAYER_ID) NULLS LAST, FIRST_LOGIN NULLS LAST;

/*
Prediction Result:
(0, '2023-01-01')
(1, '2023-01-01')
(-1000, '2026-05-25')
*/