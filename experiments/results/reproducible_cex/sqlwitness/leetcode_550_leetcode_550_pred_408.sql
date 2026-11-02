-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', -1, 3), (3, '2023-01-02', 3, NULL), (-1, '2023-01-02', 0, 1), (0, '2023-01-01', -1, 2), (0, '2023-01-02', -1, 1), (2, '2023-01-01', 2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH T AS (SELECT PLAYER_ID, CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID))) AS INTEGER) AS MIN_LOGIN_DIFF FROM ACTIVITY) SELECT ROUND(CAST(SUM(CASE WHEN MIN_LOGIN_DIFF = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM T;

/*
Prediction Result:
(0.5,)
*/