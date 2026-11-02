-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests NULL values in non-key columns (device_id, games_played) on the minimum date row to kill mutants that inner-join or filter on those columns.
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, '2020-06-15', NULL, NULL);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, '2020-06-16', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, '2020-01-01', 20, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, '2020-01-02', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(5, '2020-06-15')
(6, '2020-01-01')
*/

-- Prediction Query
SELECT PLAYER_ID, (MIN(EVENT_DATE)) AS FIRST_LOGIN FROM ACTIVITY WHERE NOT GAMES_PLAYED IS NULL GROUP BY PLAYER_ID;

/*
Prediction Result:
(5, '2020-06-16')
(6, '2020-01-01')
*/