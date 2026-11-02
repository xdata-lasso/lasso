-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', 1, 0), (3, '2023-01-02', 1, 1), (-1, '2023-01-02', 2, 0), (1, '2023-01-02', NULL, 3), (0, '2023-01-01', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH A AS (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY AS A1 LEFT JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS DT1 FROM ACTIVITY GROUP BY 1) AS A USING (PLAYER_ID) WHERE CAST((JULIANDAY(A1.EVENT_DATE) - JULIANDAY(A.DT1)) AS INTEGER) = 1) SELECT ROUND(CAST((SELECT * FROM A) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM ACTIVITY;

/*
Prediction Result:
(0.25,)
*/