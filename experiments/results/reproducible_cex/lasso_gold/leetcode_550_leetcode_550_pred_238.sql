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
WITH DATECALC AS (SELECT DISTINCT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS SECOND_DAY FROM ACTIVITY), FIRSTLOGINDATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS MIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID), LOGGED AS (SELECT COUNT(DISTINCT A.PLAYER_ID) AS LOGGED FROM DATECALC AS A CROSS JOIN FIRSTLOGINDATE AS B WHERE CAST((JULIANDAY(A.SECOND_DAY) - JULIANDAY(A.EVENT_DATE)) AS INTEGER) = 1 AND A.EVENT_DATE = B.MIN_DATE AND A.PLAYER_ID = B.PLAYER_ID), TOTALP AS (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL FROM DATECALC) SELECT ROUND(CAST(LOGGED AS REAL) / TOTAL, 2) AS FRACTION FROM LOGGED CROSS JOIN TOTALP;

/*
Prediction Result:
(0.0,)
*/