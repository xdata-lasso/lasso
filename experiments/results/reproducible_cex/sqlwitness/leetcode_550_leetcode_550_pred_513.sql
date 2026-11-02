-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', -1, 3), (-1, '2023-01-01', NULL, 3), (-1, '2023-01-02', 2, 2), (1, '2023-01-01', 1, 1), (1, '2023-01-02', NULL, 3), (0, '2023-01-01', NULL, 0), (0, '2023-01-02', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(IIF(CAST((JULIANDAY(B.EVENT_DATE) - JULIANDAY(A.EVENT_DATE)) AS INTEGER) = 1, 1, 0)) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM (SELECT PLAYER_ID, EVENT_DATE FROM (SELECT *, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DATE_RANK FROM ACTIVITY) AS T1 WHERE T1.DATE_RANK = 1) AS A LEFT JOIN (SELECT PLAYER_ID, EVENT_DATE FROM (SELECT *, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DATE_RANK FROM ACTIVITY) AS T2 WHERE T2.DATE_RANK = 2) AS B ON A.PLAYER_ID = B.PLAYER_ID;

/*
Prediction Result:
(0.75,)
*/