-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-01', 0, 1), (-1, '2023-01-01', 1, NULL), (-1, '2023-01-02', 3, 2), (0, '2023-01-01', 0, 0), (0, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH F AS (SELECT N.PLAYER_ID, MIN(N.EVENT_DATE) AS FIRST, CASE WHEN N.NEX IS NULL THEN 0 WHEN CAST((JULIANDAY(N.NEX) - JULIANDAY(N.EVENT_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END AS W FROM (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEX FROM ACTIVITY) AS N GROUP BY 1) SELECT ROUND(CAST(SUM(W = 1) AS REAL) / COUNT(*), 2) AS FRACTION FROM F;

/*
Prediction Result:
(0.67,)
*/