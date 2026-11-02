-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-01', -1, 0), (-1, '2023-01-01', 0, NULL), (3, '2023-01-02', NULL, 1), (0, '2023-01-01', 1, 1), (0, '2023-01-02', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS MIN_DATE FROM ACTIVITY GROUP BY 1) SELECT ROUND(CAST(COUNT(*) AS REAL) / (SELECT COUNT(*) FROM CTE), 2) AS FRACTION FROM ACTIVITY AS A JOIN CTE AS B ON CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(B.MIN_DATE)) AS INTEGER) = 1 AND A.PLAYER_ID = B.PLAYER_ID;

/*
Prediction Result:
(0.67,)
*/