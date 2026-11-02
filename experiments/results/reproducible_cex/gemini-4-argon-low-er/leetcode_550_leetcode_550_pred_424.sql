-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 10, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT *, FIRST_VALUE(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS FIRST_LOGIN FROM ACTIVITY) SELECT ROUND(CAST(COUNT(DISTINCT A2.PLAYER_ID) AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS FRACTION FROM FIRST_LOGIN AS A LEFT JOIN FIRST_LOGIN AS A2 ON A.PLAYER_ID = A2.PLAYER_ID AND CAST((JULIANDAY(A2.EVENT_DATE) - JULIANDAY(A.FIRST_LOGIN)) AS INTEGER) = 1;

/*
Prediction Result:
(1.0,)
*/