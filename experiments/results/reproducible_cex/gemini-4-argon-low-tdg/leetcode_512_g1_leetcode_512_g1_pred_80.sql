-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-mutations:
-- 1. Inverted correlation between event_date and device_id (catches MIN(device_id) or MAX(device_id) with GROUP BY player_id).
-- 2. Reverse insertion order (catches bare SELECT player_id, device_id GROUP BY player_id which picks arbitrary/first-inserted row in SQLite).
-- 3. Shared login dates across different players (catches missing A1.player_id = A2.player_id join condition or IN (SELECT MIN(event_date)...)).
-- 4. Different global minimum dates per player (catches missing GROUP BY player_id in subquery).
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-10', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-01', 50, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-20', 5, 8);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-05-01', 99, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-04-15', 20, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(1, 50)
(2, 20)
*/

-- Prediction Query
WITH CTE1 AS (SELECT DEVICE_ID, PLAYER_ID, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RNK FROM ACTIVITY) SELECT DEVICE_ID, PLAYER_ID FROM CTE1 WHERE RNK = 1;

/*
Prediction Result:
(50, 1)
(20, 2)
*/