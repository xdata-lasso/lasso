-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT CASE WHEN (CAST((JULIANDAY(A1.EVENT_DATE) - JULIANDAY(A2.EVENT_DATE)) AS INTEGER) = 1) OR (CAST((JULIANDAY(A1.EVENT_DATE) - JULIANDAY(A2.EVENT_DATE)) AS INTEGER) = -1) THEN A1.PLAYER_ID ELSE NULL END) AS REAL) / COUNT(DISTINCT A1.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS A1 CROSS JOIN (SELECT A3.PLAYER_ID, MIN(A3.EVENT_DATE) AS EVENT_DATE FROM ACTIVITY AS A3 GROUP BY A3.PLAYER_ID) AS A2 WHERE A1.PLAYER_ID = A2.PLAYER_ID;

/*
Prediction Result:
(1.0,)
*/