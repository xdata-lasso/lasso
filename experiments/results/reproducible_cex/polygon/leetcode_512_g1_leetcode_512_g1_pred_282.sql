-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (13, '0998-09-25', 12, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (13, '0998-01-12', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(13, None)
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT PLAYER_ID, DEVICE_ID, EVENT_DATE FROM ACTIVITY ORDER BY EVENT_DATE ASC, PLAYER_ID NULLS LAST, DEVICE_ID NULLS LAST) SELECT DISTINCT PLAYER_ID, DEVICE_ID FROM TEMP GROUP BY PLAYER_ID;

/*
Prediction Result:
(13, None)
*/