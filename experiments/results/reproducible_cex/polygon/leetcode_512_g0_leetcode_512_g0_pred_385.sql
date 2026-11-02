-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (11, '0998-09-25', 12, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (11, '0998-09-26', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(11, 12)
*/

-- Prediction Query
SELECT DISTINCT PLAYER_ID, DEVICE_ID FROM (SELECT PLAYER_ID, DEVICE_ID, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RK FROM ACTIVITY) AS T WHERE RK = 1;

/*
Prediction Result:
(11, 12)
*/