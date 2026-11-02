-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH A AS (SELECT A1.PLAYER_ID AS PLAYER_ID, CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(MINIMUM_DATE)) AS INTEGER) AS DATE_DIFF FROM ACTIVITY AS A1 INNER JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS MINIMUM_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID) SELECT ROUND(CAST((SELECT COUNT(DISTINCT PLAYER_ID) FROM A WHERE DATE_DIFF = 1) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM A), 2) AS FRACTION;

/*
Prediction Result:
(1.0,)
*/