-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (11, '0998-09-25', 13, NULL);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (10, '0998-01-12', 14, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(10, 14)
(11, 13)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT PLAYER_ID, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS FIRST_LOGIN FROM ACTIVITY) SELECT DISTINCT CTE.PLAYER_ID, DEVICE_ID FROM ACTIVITY AS A JOIN CTE ON A.PLAYER_ID = CTE.PLAYER_ID AND FIRST_LOGIN = A.EVENT_DATE;

/*
Prediction Result:
(10, 14)
(11, 13)
*/