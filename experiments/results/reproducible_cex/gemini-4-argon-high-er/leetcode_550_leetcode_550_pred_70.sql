-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200101, 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200102, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
WITH T1 AS (SELECT A1.PLAYER_ID, MIN(A1.EVENT_DATE) AS D1, MIN(A2.EVENT_DATE) AS D2 FROM ACTIVITY AS A1 LEFT JOIN ACTIVITY AS A2 ON A2.EVENT_DATE = A1.EVENT_DATE + 1 AND A1.PLAYER_ID = A2.PLAYER_ID GROUP BY A1.PLAYER_ID) SELECT ROUND(CAST(COUNT(DISTINCT PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM T1 WHERE CAST((JULIANDAY(D2) - JULIANDAY(D1)) AS INTEGER) = 1;

/*
Prediction Result:
(0.0,)
*/