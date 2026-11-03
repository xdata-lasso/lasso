-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1007, '1974-05-05', 1008, 1009);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1010, NULL, 1011, 1012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1007, 1008)
*/

-- Prediction Query
WITH X AS (SELECT PLAYER_ID, DEVICE_ID, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DENSER FROM ACTIVITY) SELECT DISTINCT PLAYER_ID, DEVICE_ID FROM X WHERE DENSER = 1;

/*
Prediction Result:
(1007, 1008)
(1010, 1011)
*/