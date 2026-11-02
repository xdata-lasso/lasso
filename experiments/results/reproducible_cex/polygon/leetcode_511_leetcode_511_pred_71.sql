-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, '0998-01-12', -719, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(4, '0998-01-12')
*/

-- Prediction Query
SELECT MIN(EVENT_DATE) AS FIRST_LOGIN, PLAYER_ID FROM ACTIVITY GROUP BY 2;

/*
Prediction Result:
('0998-01-12', 4)
*/