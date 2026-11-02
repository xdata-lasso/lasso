-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, '1002-06-26', 6, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, '0998-01-12', 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(4, '0998-01-12')
*/

-- Prediction Query
SELECT PLAYER_ID, (MIN(EVENT_DATE)) AS FIRST_LOGIN FROM ACTIVITY WHERE NOT GAMES_PLAYED IS NULL GROUP BY PLAYER_ID;

/*
Prediction Result:
(4, '1002-06-26')
*/