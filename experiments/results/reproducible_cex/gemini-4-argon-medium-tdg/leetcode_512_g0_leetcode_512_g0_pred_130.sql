-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-mutations: MAX instead of MIN, missing GROUP BY, and date matching without player_id matching.
-- Player 2 logs in on Player 1's first login date (2023-05-01), which is NOT Player 2's first login date.
-- Also tests SQLite's bare column behavior in GROUP BY (device_id vs min(device_id) vs max(device_id)) by having the earliest date correspond to a middle device_id.
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-10', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-01', 20, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-20', 30, 8);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-04-15', 200, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-05-01', 100, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1, 20)
(2, 200)
*/

-- Prediction Query
SELECT DEVICE_ID, PLAYER_ID FROM (SELECT DEVICE_ID, PLAYER_ID, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS A WHERE RNK = 1;

/*
Prediction Result:
(20, 1)
(200, 2)
*/