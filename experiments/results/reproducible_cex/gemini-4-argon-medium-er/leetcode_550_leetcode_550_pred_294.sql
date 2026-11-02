-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-02', 1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH T1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID), T2 AS (SELECT COUNT(T1.PLAYER_ID) AS NUM FROM T1 JOIN ACTIVITY ON T1.PLAYER_ID = ACTIVITY.PLAYER_ID AND CAST((JULIANDAY(ACTIVITY.EVENT_DATE) - JULIANDAY(T1.EVENT_DATE)) AS INTEGER) = 1) SELECT ROUND(CAST(COALESCE((SELECT NUM FROM T2), 0) AS REAL) / (SELECT COUNT(DISTINCT (PLAYER_ID)) FROM ACTIVITY), 2) AS FRACTION;

/*
Prediction Result:
(1.0,)
*/