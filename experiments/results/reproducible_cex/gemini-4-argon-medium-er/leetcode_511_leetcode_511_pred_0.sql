-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, NULL, 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(1, '2020-01-01')
*/

-- Prediction Query
SELECT DISTINCT PLAYER_ID, FIRST_VALUE(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY;

/*
Prediction Result:
(1, None)
*/