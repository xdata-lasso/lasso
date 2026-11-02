-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (8, '0998-01-11', NULL, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (10, '0998-01-12', 11, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(8, None)
(10, 11)
*/

-- Prediction Query
WITH TEMP AS (SELECT PLAYER_ID, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS FIRST_DATE, EVENT_DATE, DEVICE_ID FROM ACTIVITY) SELECT PLAYER_ID, DEVICE_ID FROM TEMP WHERE EVENT_DATE = FIRST_DATE;

/*
Prediction Result:
(8, None)
(10, 11)
*/