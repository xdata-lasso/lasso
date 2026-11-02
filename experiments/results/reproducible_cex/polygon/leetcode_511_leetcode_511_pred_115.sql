-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (6, '0998-01-12', 6, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(6, '0998-01-12')
*/

-- Prediction Query
SELECT PLAYER_ID, FIRST_LOGIN FROM (SELECT T1.PLAYER_ID, T1.EVENT_DATE AS FIRST_LOGIN, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS ROW_NUM FROM ACTIVITY AS T1) AS T2 WHERE T2.ROW_NUM = 1;

/*
Prediction Result:
(6, '0998-01-12')
*/