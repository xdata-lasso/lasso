-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (10, '0998-09-25', 9, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (10, '0998-01-12', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(10, None)
*/

-- Prediction Query
SELECT PLAYER_ID, DEVICE_ID FROM (SELECT DISTINCT PLAYER_ID, DEVICE_ID, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS SRT FROM ACTIVITY) AS TEMP WHERE SRT = 1;

/*
Prediction Result:
(10, None)
*/