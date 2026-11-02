-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (9, '0998-01-12', -719, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (5, '0998-01-12', -719, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(5, '0998-01-12')
(9, '0998-01-12')
*/

-- Prediction Query
SELECT DISTINCT (A.PLAYER_ID), MIN(EVENT_DATE) OVER (PARTITION BY A.PLAYER_ID) AS FIRST_LOGIN FROM ACTIVITY AS A;

/*
Prediction Result:
(5, '0998-01-12')
(9, '0998-01-12')
*/