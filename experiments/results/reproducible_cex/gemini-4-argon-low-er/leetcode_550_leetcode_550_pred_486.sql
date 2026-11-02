-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST FROM ACTIVITY GROUP BY 1), RETURNS AS (SELECT A.PLAYER_ID FROM ACTIVITY AS A JOIN FIRST AS F ON CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(F.FIRST)) AS INTEGER) = 1 AND A.PLAYER_ID = F.PLAYER_ID) SELECT ROUND(CAST(COUNT(DISTINCT R.PLAYER_ID) AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS FRACTION FROM RETURNS AS R CROSS JOIN ACTIVITY AS A;

/*
Prediction Result:
(1.0,)
*/