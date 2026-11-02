-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, NULL, 10, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-01-01', 20, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2022-01-01', 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1, 20)
(2, 30)
*/

-- Prediction Query
SELECT DISTINCT PLAYER_ID, FIRST_VALUE(DEVICE_ID) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DEVICE_ID FROM ACTIVITY ORDER BY EVENT_DATE, PLAYER_ID NULLS LAST, DEVICE_ID NULLS LAST;

/*
Prediction Result:
(1, 10)
(2, 30)
*/