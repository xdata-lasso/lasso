-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT player_id, MIN(event_date) AS first_login FROM activity GROUP BY player_id;

/*
Gold Result:
(1, '2020-01-01')
*/

-- Prediction Query
SELECT A1.PLAYER_ID, A1.EVENT_DATE AS FIRST_LOGIN FROM ACTIVITY AS A1 WHERE NOT EXISTS(SELECT * FROM ACTIVITY AS A2 WHERE A2.PLAYER_ID = A1.PLAYER_ID AND A2.EVENT_DATE < A1.EVENT_DATE);

/*
Prediction Result:
(1, None)
(1, '2020-01-01')
*/