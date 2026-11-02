-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests NULL values in non-primary key columns (device_id and games_played) on the minimum event_date to kill mutants that erroneously filter out NULLs.
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2021-01-01', NULL, NULL);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2021-06-01', 5, 10);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2021-03-15', 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(1, '2021-01-01')
(2, '2021-03-15')
*/

-- Prediction Query
SELECT PLAYER_ID, (MIN(EVENT_DATE)) AS FIRST_LOGIN FROM ACTIVITY WHERE NOT GAMES_PLAYED IS NULL GROUP BY PLAYER_ID;

/*
Prediction Result:
(1, '2021-06-01')
*/