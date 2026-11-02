-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-02', 10, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH T AS (SELECT A.*, B.FIRST_DATE, CASE WHEN CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(B.FIRST_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END AS FLAG FROM ACTIVITY AS A LEFT JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS B ON A.PLAYER_ID = B.PLAYER_ID) SELECT ROUND(CAST(SUM(FLAG) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM T;

/*
Prediction Result:
(1.0,)
*/