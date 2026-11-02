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
SELECT ROUND(CAST(SUM(CASE WHEN NOT EVENT_DATE IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(PLAYER_ID), 2) AS FRACTION FROM (SELECT P1.PLAYER_ID, FIRSTLOG, EVENT_DATE FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRSTLOG FROM ACTIVITY GROUP BY PLAYER_ID) AS P1 LEFT JOIN ACTIVITY ON ACTIVITY.PLAYER_ID = P1.PLAYER_ID AND CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(FIRSTLOG)) AS INTEGER) = 1) AS P2;

/*
Prediction Result:
(0.0,)
*/