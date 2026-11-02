-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard ISO date strings vs SQLite numeric addition, multiple logins, and rounding
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-01-01', 10, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2023-01-02', 10, 3);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2023-01-01', 20, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-01-05', 30, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2023-01-07', 30, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TEMP AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1, DATE('9999-08-29')) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS LOGIN_RANK FROM ACTIVITY), TEMP_DIFF AS (SELECT PLAYER_ID, EVENT_DATE, NEXT_DATE, LOGIN_RANK, CAST((JULIANDAY(NEXT_DATE) - JULIANDAY(EVENT_DATE)) AS INTEGER) AS DATE_DIFF FROM TEMP), TEMP_DIFF_COUNT AS (SELECT COUNT(DISTINCT (PLAYER_ID)) AS PLY_COUNT FROM TEMP_DIFF WHERE DATE_DIFF = 1 AND LOGIN_RANK = 1) SELECT ROUND(CAST(PLY_COUNT * 1.0 AS REAL) / (SELECT COUNT(DISTINCT (PLAYER_ID)) FROM ACTIVITY), 2) AS FRACTION FROM TEMP_DIFF_COUNT;

/*
Prediction Result:
(0.33,)
*/