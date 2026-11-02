-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-01-01', 2, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1, 2)
*/

-- Prediction Query
SELECT B.DEVICE_ID, B.PLAYER_ID FROM ACTIVITY AS B INNER JOIN (SELECT MIN(EVENT_DATE) AS EVENT_DATE, DEVICE_ID, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID) AS A ON B.EVENT_DATE = A.EVENT_DATE AND A.PLAYER_ID = B.PLAYER_ID;

/*
Prediction Result:
(2, 1)
*/