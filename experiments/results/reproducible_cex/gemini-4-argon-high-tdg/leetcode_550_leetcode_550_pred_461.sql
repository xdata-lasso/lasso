-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20230801, 5, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20230802, 5, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20230804, 6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS FIRST_LOGIN_DT, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_LOGIN_DT FROM ACTIVITY), CTE2 AS (SELECT PLAYER_ID, FIRST_LOGIN_DT FROM CTE WHERE NEXT_LOGIN_DT - FIRST_LOGIN_DT = 1) SELECT ROUND(CAST((SELECT COUNT(DISTINCT (PLAYER_ID)) FROM CTE2) AS REAL) / (SELECT COUNT(DISTINCT (PLAYER_ID)) FROM ACTIVITY), 2) AS FRACTION FROM CTE2 AS C INNER JOIN ACTIVITY AS A ON C.PLAYER_ID = A.PLAYER_ID GROUP BY 1;

/*
Prediction Result:
*/