-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, NULL, 10, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
*/

-- Prediction Query
WITH TABLET AS (SELECT A.*, RANK() OVER (PARTITION BY A.PLAYER_ID ORDER BY A.EVENT_DATE) AS RANK FROM ACTIVITY AS A) SELECT T.PLAYER_ID, T.DEVICE_ID FROM TABLET AS T WHERE T.RANK = 1;

/*
Prediction Result:
(1, 10)
*/