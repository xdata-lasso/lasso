-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH T3 AS (SELECT COUNT(PLAYER_ID) AS COUNT_PLAYER_CONSEC FROM (SELECT PLAYER_ID, SUM(CONSEC_OR_NOT) AS PLAYER_CONSEC FROM (SELECT PLAYER_ID, IIF(NUM = 1, 1, 0) AS CONSEC_OR_NOT FROM (SELECT PLAYER_ID, CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID))) AS INTEGER) AS NUM FROM ACTIVITY) AS T0) AS T1 GROUP BY PLAYER_ID) AS T2 WHERE PLAYER_CONSEC <> 0), T5 AS (SELECT COUNT(DISTINCT PLAYER_ID) AS COUNT_PLAYER FROM ACTIVITY) SELECT ROUND(CAST(COUNT_PLAYER_CONSEC AS REAL) / COUNT_PLAYER, 2) AS FRACTION FROM T3 CROSS JOIN T5;

/*
Prediction Result:
(1.0,)
*/