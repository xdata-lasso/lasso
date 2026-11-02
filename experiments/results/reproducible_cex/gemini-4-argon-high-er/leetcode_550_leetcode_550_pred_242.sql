-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-01-31', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-02-01', 1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_ACTIVITY AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) SELECT ROUND(CAST(SUM(IIF(T2.PLAYER_ID IS NULL, 0, 1)) AS REAL) / COUNT(*), 2) AS FRACTION FROM (SELECT DISTINCT PLAYER_ID FROM ACTIVITY) AS T1 LEFT JOIN (SELECT DISTINCT T1.PLAYER_ID FROM FIRST_ACTIVITY AS T1 JOIN ACTIVITY AS T2 ON T2.PLAYER_ID = T1.PLAYER_ID AND CAST((JULIANDAY(T2.EVENT_DATE) - JULIANDAY(T1.EVENT_DATE)) AS INTEGER) = 1) AS T2 ON T2.PLAYER_ID = T1.PLAYER_ID;

/*
Prediction Result:
(1.0,)
*/