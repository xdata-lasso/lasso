-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-01', 2, 2), (-1, '2023-01-01', 1, NULL), (3, '2023-01-02', NULL, 3), (1, '2023-01-02', -1, NULL), (0, '2023-01-01', 1, 2), (0, '2023-01-02', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH LOGIN AS (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RN FROM ACTIVITY), TARGET_PLAYER AS (SELECT A.PLAYER_ID FROM ACTIVITY AS A JOIN LOGIN AS L ON A.PLAYER_ID = L.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(L.EVENT_DATE)) AS INTEGER) = 1 WHERE RN = 1) SELECT ROUND(CAST((SELECT COUNT(*) FROM TARGET_PLAYER) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION;

/*
Prediction Result:
(0.5,)
*/