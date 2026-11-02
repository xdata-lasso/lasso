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
WITH A AS (SELECT COUNT(DISTINCT (PLAYER_ID)) AS CON_PLAYER FROM (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS FIRST_DATE FROM ACTIVITY) AS A WHERE CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(FIRST_DATE)) AS INTEGER) = 1), B AS (SELECT COUNT(DISTINCT (PLAYER_ID)) AS TOTAL FROM ACTIVITY) SELECT ROUND(CAST((SELECT CON_PLAYER FROM A) AS REAL) / (SELECT TOTAL FROM B), 2) AS FRACTION;

/*
Prediction Result:
(1.0,)
*/