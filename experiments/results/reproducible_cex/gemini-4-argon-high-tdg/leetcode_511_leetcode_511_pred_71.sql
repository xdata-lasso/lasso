-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-05-02', 2, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 3, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2017-06-25', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2018-07-03', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2016-01-02', 4, 10);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2015-12-31', 5, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(1, '2016-03-01')
(2, '2017-06-25')
(3, '2015-12-31')
*/

-- Prediction Query
SELECT MIN(EVENT_DATE) AS FIRST_LOGIN, PLAYER_ID FROM ACTIVITY GROUP BY 2;

/*
Prediction Result:
('2016-03-01', 1)
('2017-06-25', 2)
('2015-12-31', 3)
*/