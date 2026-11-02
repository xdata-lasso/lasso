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
SELECT B.DEVICE_ID, B.PLAYER_ID FROM ACTIVITY AS B INNER JOIN (SELECT MIN(EVENT_DATE) AS EVENT_DATE, DEVICE_ID, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID) AS A ON B.EVENT_DATE = A.EVENT_DATE AND A.PLAYER_ID = B.PLAYER_ID;

/*
Prediction Result:
(10, 1)
(99, 2)
*/