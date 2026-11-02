-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-05-10', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-15', 25, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-03-20', 40, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2020-02-01', 25, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2019-12-31', 5, 100);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2020-01-01', 50, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1, 25)
(2, 25)
(3, 5)
*/

-- Prediction Query
SELECT B.DEVICE_ID, B.PLAYER_ID FROM ACTIVITY AS B INNER JOIN (SELECT MIN(EVENT_DATE) AS EVENT_DATE, DEVICE_ID, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID) AS A ON B.EVENT_DATE = A.EVENT_DATE AND A.PLAYER_ID = B.PLAYER_ID;

/*
Prediction Result:
(25, 1)
(25, 2)
(5, 3)
*/