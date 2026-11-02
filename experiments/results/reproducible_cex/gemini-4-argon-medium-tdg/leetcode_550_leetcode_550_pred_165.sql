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
SELECT ROUND(CAST(COUNT(DISTINCT PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_EVENT, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS A WHERE RNK = 1 AND CAST((JULIANDAY(NEXT_EVENT) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1;

/*
Prediction Result:
(0.33,)
*/