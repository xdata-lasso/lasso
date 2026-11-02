-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT T1.PLAYER_ID, T1.DEVICE_ID FROM ACTIVITY AS T1 INNER JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS T2 ON T1.PLAYER_ID = T2.PLAYER_ID AND T1.EVENT_DATE = T2.DATE) AS U;

/*
Prediction Result:
*/