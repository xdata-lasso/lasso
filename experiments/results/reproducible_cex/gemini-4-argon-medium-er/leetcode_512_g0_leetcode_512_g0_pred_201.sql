-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '2020-01-01', 3, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '2020-01-02', 4, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT PLAYER_ID, DEVICE_ID FROM ACTIVITY WHERE (PLAYER_ID, EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID);

/*
Gold Result:
(1, 2)
*/

-- Prediction Query
WITH CTE AS (SELECT *, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS MIN_DATE FROM ACTIVITY) SELECT PLAYER_ID, DEVICE_ID FROM CTE WHERE EVENT_DATE = MIN_DATE ORDER BY 1, PLAYER_ID NULLS LAST, DEVICE_ID NULLS LAST;

/*
Prediction Result:
(None, 3)
(1, 2)
*/