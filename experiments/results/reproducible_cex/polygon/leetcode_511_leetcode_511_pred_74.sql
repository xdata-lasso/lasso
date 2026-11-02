-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (5, '0998-09-25', 5, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (5, '0998-09-26', 5, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(5, '0998-09-25')
*/

-- Prediction Query
SELECT PLAYER_ID, FIRST_LOGIN FROM (SELECT PLAYER_ID, EVENT_DATE AS FIRST_LOGIN, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS A WHERE RNK = 1;

/*
Prediction Result:
(5, '0998-09-25')
*/