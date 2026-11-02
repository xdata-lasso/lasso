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
WITH EVENTS_RNKED AS (SELECT *, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DT_RNK FROM ACTIVITY) SELECT ROUND(CAST(COUNT(DISTINCT CASE WHEN E1.DT_RNK = 1 AND CAST((JULIANDAY(E2.EVENT_DATE) - JULIANDAY(E1.EVENT_DATE)) AS INTEGER) = 1 THEN E1.PLAYER_ID ELSE NULL END) AS REAL) / COUNT(DISTINCT E1.PLAYER_ID), 2) AS FRACTION FROM EVENTS_RNKED AS E1 JOIN EVENTS_RNKED AS E2 ON E1.PLAYER_ID = E2.PLAYER_ID;

/*
Prediction Result:
(1.0,)
*/