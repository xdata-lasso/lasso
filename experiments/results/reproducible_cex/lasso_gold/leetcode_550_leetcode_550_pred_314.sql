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
SELECT ROUND(CAST(SUM(CASE WHEN A.PLAYER_ID IS NULL THEN 0 ELSE 1 END) AS REAL) / COUNT(TMP.PLAYER_ID) * 1.0, 2) AS FRACTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM ACTIVITY GROUP BY 1) AS TMP LEFT JOIN (SELECT DISTINCT PLAYER_ID, EVENT_DATE FROM ACTIVITY) AS A ON TMP.PLAYER_ID = A.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(TMP.FIRST_DATE)) AS INTEGER) = 1;

/*
Prediction Result:
(0.0,)
*/