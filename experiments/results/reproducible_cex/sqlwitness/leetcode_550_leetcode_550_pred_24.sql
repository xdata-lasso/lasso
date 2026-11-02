-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-01', 2, 2), (3, '2023-01-01', 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT SUB.PLAYER_ID) AS REAL) / COUNT(DISTINCT A0.PLAYER_ID), 2) AS FRACTION FROM (SELECT * FROM (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS LEAD0, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RANK0 FROM ACTIVITY) AS SUB0 WHERE LEAD0 - EVENT_DATE = 1 AND RANK0 = 1) AS SUB CROSS JOIN ACTIVITY AS A0;

/*
Prediction Result:
(None,)
*/