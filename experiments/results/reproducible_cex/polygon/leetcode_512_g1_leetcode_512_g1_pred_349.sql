-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (11, '0998-09-25', NULL, NULL);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (13, '0998-01-12', 14, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(11, None)
(13, 14)
*/

-- Prediction Query
SELECT PLAYER_ID, DEVICE_ID FROM (SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS MIN_DATE FROM ACTIVITY) AS A WHERE EVENT_DATE = MIN_DATE;

/*
Prediction Result:
(11, None)
(13, 14)
*/