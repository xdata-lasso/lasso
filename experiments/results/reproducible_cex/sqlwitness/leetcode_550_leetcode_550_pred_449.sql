-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', NULL, 1), (-1, '2023-01-01', 1, 1), (3, '2023-01-02', 1, 3), (-1, '2023-01-02', NULL, NULL), (1, '2023-01-01', 2, 2), (0, '2023-01-01', 0, 3), (0, '2023-01-02', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_LOGINS AS (SELECT PLAYER_ID, EVENT_DATE FROM (SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RN FROM ACTIVITY) AS A WHERE RN = 1) SELECT ROUND(CAST(COUNT(DISTINCT A.PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM ACTIVITY AS A JOIN FIRST_LOGINS AS F ON A.PLAYER_ID = F.PLAYER_ID WHERE DATE(F.EVENT_DATE, '1 DAY') = A.EVENT_DATE;

/*
Prediction Result:
(0.4,)
*/