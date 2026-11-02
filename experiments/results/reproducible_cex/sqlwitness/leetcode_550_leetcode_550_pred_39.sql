-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', NULL, NULL), (-1, '2023-01-01', 2, 3), (3, '2023-01-02', 1, 0), (-1, '2023-01-02', 2, 0), (0, '2023-01-01', 2, 0), (0, '2023-01-02', 0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(CASE WHEN CAST((JULIANDAY(NEXTDAY) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM (SELECT *, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXTDAY, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DAY_RANK FROM ACTIVITY) AS BASE WHERE DAY_RANK = 1;

/*
Prediction Result:
(0.5,)
*/