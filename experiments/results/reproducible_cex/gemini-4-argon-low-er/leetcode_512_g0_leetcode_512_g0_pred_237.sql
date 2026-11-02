-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, NULL, 10, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT A.PLAYER_ID, B.DEVICE_ID FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE = B.EVENT_DATE;

/*
Prediction Result:
(1, None)
*/