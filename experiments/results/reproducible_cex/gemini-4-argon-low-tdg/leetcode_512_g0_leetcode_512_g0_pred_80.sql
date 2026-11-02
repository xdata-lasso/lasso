-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-05-02', 20, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-04-01', 5, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2016-04-01', 99, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1, 10)
(2, 99)
*/

-- Prediction Query
WITH CTE1 AS (SELECT DEVICE_ID, PLAYER_ID, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RNK FROM ACTIVITY) SELECT DEVICE_ID, PLAYER_ID FROM CTE1 WHERE RNK = 1;

/*
Prediction Result:
(10, 1)
(99, 2)
*/