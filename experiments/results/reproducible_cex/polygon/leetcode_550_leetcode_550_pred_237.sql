-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (14, '0998-09-25', NULL, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (13, '0998-01-12', 18, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, EVENT_DATE, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS LOGINRANK FROM ACTIVITY) SELECT ROUND(CAST(SUM(CASE WHEN CAST((JULIANDAY(L2.EVENT_DATE) - JULIANDAY(L1.EVENT_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM (SELECT PLAYER_ID, EVENT_DATE FROM CTE WHERE LOGINRANK = 1) AS L1 JOIN (SELECT PLAYER_ID, EVENT_DATE FROM CTE WHERE LOGINRANK = 2) AS L2 ON L1.PLAYER_ID = L2.PLAYER_ID;

/*
Prediction Result:
(None,)
*/