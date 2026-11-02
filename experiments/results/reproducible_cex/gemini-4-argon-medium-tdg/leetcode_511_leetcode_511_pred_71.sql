-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic multiple players, out-of-order insertion, and kills mutants that sort/filter by device_id or games_played (including games_played = 0) instead of event_date.
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-10', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-15', 50, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-03-20', 5, 12);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2022-12-31', 100, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(1, '2023-01-15')
(2, '2022-12-31')
*/

-- Prediction Query
SELECT MIN(EVENT_DATE) AS FIRST_LOGIN, PLAYER_ID FROM ACTIVITY GROUP BY 2;

/*
Prediction Result:
('2023-01-15', 1)
('2022-12-31', 2)
*/