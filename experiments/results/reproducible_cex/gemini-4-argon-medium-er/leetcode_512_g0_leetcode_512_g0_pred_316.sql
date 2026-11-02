-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, NULL, 10, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 20, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '2020-01-01', 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1, 20)
*/

-- Prediction Query
SELECT P.PLAYER_ID, P.DEVICE_ID FROM (SELECT PLAYER_ID, DEVICE_ID, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY ORDER BY 1, ACTIVITY.player_id NULLS LAST, ACTIVITY.event_date NULLS LAST) AS P WHERE P.RNK = 1;

/*
Prediction Result:
(None, 30)
(1, 10)
*/