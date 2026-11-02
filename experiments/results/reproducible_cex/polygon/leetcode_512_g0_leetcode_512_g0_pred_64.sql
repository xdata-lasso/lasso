-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (8, '0998-09-25', 9, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(8, 9)
*/

-- Prediction Query
SELECT T.PLAYER_ID, T.DEVICE_ID FROM (SELECT AC.PLAYER_ID, AC.DEVICE_ID, RANK() OVER (PARTITION BY AC.PLAYER_ID ORDER BY AC.EVENT_DATE ASC) AS PLAY_RANK FROM ACTIVITY AS AC) AS T WHERE T.PLAY_RANK = 1;

/*
Prediction Result:
(8, 9)
*/