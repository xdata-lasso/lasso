-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1011, '1976-07-07', 1012, 1013);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1011, '1977-08-08', 1014, 1015);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1016, NULL, 1017, 1018);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1016, NULL, 1019, 1020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT A1.PLAYER_ID, A1.DEVICE_ID FROM ACTIVITY AS A1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON (A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = A2.FIRST_LOGIN);

/*
Gold Result:
(1011, 1012)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, DEVICE_ID, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RANKING FROM ACTIVITY) SELECT PLAYER_ID, DEVICE_ID FROM CTE WHERE RANKING = 1;

/*
Prediction Result:
(1011, 1012)
(1016, 1017)
(1016, 1019)
*/