-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', 1, 2), (3, '2023-01-02', -1, 0), (-1, '2023-01-02', -1, 1), (1, '2023-01-02', NULL, 0), (0, '2023-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT SUM(CASE WHEN ABS(CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(SECOND_LOGIN)) AS INTEGER)) = 1 THEN 1 ELSE 0 END) AS NUMERATOR FROM (SELECT A.*, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS SECOND_LOGIN, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS LOGIN_NUM FROM ACTIVITY AS A) AS B WHERE B.LOGIN_NUM = 1), TOTAL_COUNT AS (SELECT COUNT(DISTINCT PLAYER_ID) AS DEN FROM ACTIVITY) SELECT ROUND(CAST(NUMERATOR AS REAL) / DEN, 2) AS FRACTION FROM CTE CROSS JOIN TOTAL_COUNT WHERE 1 = 1;

/*
Prediction Result:
(0.25,)
*/