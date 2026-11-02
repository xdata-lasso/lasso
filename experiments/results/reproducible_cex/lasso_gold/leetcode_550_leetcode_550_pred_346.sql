-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1021, 10, 1013, 1015);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1022, '1970-01-01', 1013, 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COALESCE(COUNT(DISTINCT PLAYER_ID), 0) AS REAL) / T1.TOTAL, 2) AS FRACTION FROM (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS IDX FROM ACTIVITY GROUP BY PLAYER_ID, EVENT_DATE) AS T CROSS JOIN (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL FROM ACTIVITY) AS T1 WHERE IDX = 1 AND (CAST((JULIANDAY(T.NEXT_DATE) - JULIANDAY(EVENT_DATE)) AS INTEGER)) = 1 AND NOT T.NEXT_DATE IS NULL;

/*
Prediction Result:
(None,)
*/