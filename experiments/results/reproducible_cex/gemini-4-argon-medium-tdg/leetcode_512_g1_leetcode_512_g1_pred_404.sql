-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-05-02', 3, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2017-06-25', 3, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2018-07-03', 4, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2016-03-02', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(1, 2)
(2, 3)
(3, 1)
*/

-- Prediction Query
SELECT B.DEVICE_ID, B.PLAYER_ID FROM ACTIVITY AS B INNER JOIN (SELECT MIN(EVENT_DATE) AS EVENT_DATE, DEVICE_ID, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID) AS A ON B.EVENT_DATE = A.EVENT_DATE AND A.PLAYER_ID = B.PLAYER_ID;

/*
Prediction Result:
(2, 1)
(3, 2)
(1, 3)
*/