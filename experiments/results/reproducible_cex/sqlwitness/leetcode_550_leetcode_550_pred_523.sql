-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2026-10-01', 1, 1), (2, '2023-01-02', NULL, 1), (-1, '2026-10-01', NULL, NULL), (0, '2026-10-01', NULL, 0), (0, '2023-01-01', -1, 2), (0, '2023-01-02', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH BASE AS (SELECT EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_EVENT, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS LOGIN_NUM FROM ACTIVITY) SELECT ROUND(CAST(SUM(CASE WHEN CAST((JULIANDAY(NEXT_EVENT) - JULIANDAY(EVENT_DATE)) AS INTEGER) = '1' THEN 1 ELSE 0 END) AS REAL) / COUNT(*), 2) AS FRACTION FROM BASE WHERE LOGIN_NUM = 1;

/*
Prediction Result:
(0.25,)
*/