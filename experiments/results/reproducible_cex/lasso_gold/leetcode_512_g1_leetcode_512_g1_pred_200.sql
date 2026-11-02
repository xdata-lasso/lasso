-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1059, '1990-10-21', 1060, 1061);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '1991-11-22', 1063, 1064);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(1059, 1060)
*/

-- Prediction Query
WITH CTE AS (SELECT *, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS MIN_DATE FROM ACTIVITY) SELECT PLAYER_ID, DEVICE_ID FROM CTE WHERE EVENT_DATE = MIN_DATE;

/*
Prediction Result:
(None, 1063)
(1059, 1060)
*/