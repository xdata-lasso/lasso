-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-05-10', 10, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-15', 25, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-08-20', 40, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-03-01', 100, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-01', 5, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2022-12-31', 50, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(1, 25)
(2, 100)
(3, 50)
*/

-- Prediction Query
SELECT DEVICE_ID, PLAYER_ID FROM (SELECT DEVICE_ID, PLAYER_ID, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS A WHERE RNK = 1;

/*
Prediction Result:
(25, 1)
(100, 2)
(50, 3)
*/