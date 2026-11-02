-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1007, '1974-05-05', 1008, 1009);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1010, NULL, 1011, 1012);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1010, '1976-07-07', 1013, 1014);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(1007, '1974-05-05')
(1010, '1976-07-07')
*/

-- Prediction Query
SELECT K.PLAYER_ID AS PLAYER_ID, K.EVENT_DATE AS FIRST_LOGIN FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS R FROM ACTIVITY) AS K WHERE K.R = 1;

/*
Prediction Result:
(1007, '1974-05-05')
(1010, None)
*/