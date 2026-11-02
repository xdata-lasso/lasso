-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 2, 0), (3, '2023-01-01', 2, 2), (-1, '2023-01-01', -1, 1), (3, '2023-01-02', 1, 1), (-1, '2023-01-02', 1, 3), (-1000, '2025-06-16', -1, NULL), (1, '2023-01-01', 3, NULL), (-1000, '2025-02-19', 3, 1), (1, '2023-01-02', 2, 1), (-1000, '2026-07-25', NULL, 1), (-1000, '2026-05-25', -1, 2), (-1000, '2025-10-11', NULL, 0), (0, '2023-01-01', -1, NULL), (-1000, '2025-10-18', -1, 0), (0, '2023-01-02', 0, 3), (-1000, '2024-11-24', -1, 3), (2, '2023-01-01', 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(CASE WHEN NEW.EVENT_DATE2 IS NULL THEN 0 ELSE 1 END) AS REAL) / COUNT(DISTINCT NEW.PLAYER_ID), 2) AS FRACTION FROM (SELECT A1.PLAYER_ID, A1.EVENT_DATE AS EVENT_DATE1, A2.EVENT_DATE AS EVENT_DATE2, ROW_NUMBER() OVER (PARTITION BY A1.PLAYER_ID ORDER BY A1.EVENT_DATE ASC) AS R FROM ACTIVITY AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND A2.EVENT_DATE - A1.EVENT_DATE = 1) AS NEW WHERE NEW.R = 1;

/*
Prediction Result:
(0.17,)
*/