-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-10, -10.234, 1320, 1322);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-10, -9.234, 1327.0, 1331.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-10, 10, 1324, 1326);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-10, 11, 1331.0, 1335.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
WITH FIRST_DATE_CTE AS (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS MIN_DATE FROM ACTIVITY AS A) SELECT ROUND(CAST(B.NEXT_DAY_LOGIN AS REAL) / B.TOTAL_PLAYERS, 2) AS FRACTION FROM (SELECT SUM(CASE WHEN ABS(CAST((JULIANDAY(MIN_DATE) - JULIANDAY(EVENT_DATE)) AS INTEGER)) = 1 THEN 1 ELSE 0 END) AS NEXT_DAY_LOGIN, COUNT(DISTINCT PLAYER_ID) AS TOTAL_PLAYERS FROM FIRST_DATE_CTE) AS B;

/*
Prediction Result:
(0.0,)
*/