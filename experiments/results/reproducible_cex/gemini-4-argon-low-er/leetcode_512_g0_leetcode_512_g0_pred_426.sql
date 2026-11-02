-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '2020-01-01', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
*/

-- Prediction Query
WITH DF1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGGED_IN FROM ACTIVITY GROUP BY 1) SELECT DF1.PLAYER_ID AS PLAYER_ID, DF2.DEVICE_ID FROM DF1 LEFT JOIN (SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE FROM ACTIVITY) AS DF2 ON DF1.PLAYER_ID = DF2.PLAYER_ID AND DF1.FIRST_LOGGED_IN = DF2.EVENT_DATE;

/*
Prediction Result:
(None, None)
*/