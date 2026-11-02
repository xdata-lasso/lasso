-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-02', 1, 3), (1, '2023-01-01', -1, 1), (3, '2023-01-02', NULL, 1), (2, '2023-01-02', 2, NULL), (2, '2023-01-01', 0, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT COUNT(DISTINCT PLAYER_ID) AS COUNT1 FROM (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1, 0) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_DAY, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS T WHERE CAST((JULIANDAY(NEXT_DAY) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1 AND RNK = 1) SELECT ROUND(CAST(CTE.COUNT1 AS REAL) / COUNT(DISTINCT ACTIVITY.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY CROSS JOIN CTE;

/*
Prediction Result:
(0.25,)
*/