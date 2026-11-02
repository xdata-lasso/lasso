-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '1977-08-08', 1018, 1019);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '1977-08-08', 1020, 1021);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(None, '1977-08-08')
*/

-- Prediction Query
SELECT DISTINCT (T.PLAYER_ID), R.FIRST_LOGIN FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS R JOIN ACTIVITY AS T ON T.PLAYER_ID = R.PLAYER_ID;

/*
Prediction Result:
*/