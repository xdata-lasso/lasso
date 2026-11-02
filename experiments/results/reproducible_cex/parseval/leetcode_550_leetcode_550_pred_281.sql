-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: activity --
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2025-06-17', 1, 1258409369);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-06-07', 1, 247012447);

INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-11-08', -734455130, 1744686505);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TMP AS (SELECT PLAYER_ID, DEVICE_ID, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS FIRST_DATE, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_DATE FROM ACTIVITY) SELECT ROUND(CAST(SUM(CASE WHEN NEXT_DATE - FIRST_DATE = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM TMP;

/*
Prediction Result:
(1.0,)
*/