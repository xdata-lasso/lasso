-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-02', -1, 2), (1, '2023-01-01', NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH PLAYER_FIRST_LOGINS AS (SELECT PLAYER_ID, FIRST_LOGIN, DATE(FIRST_LOGIN, '1 DAY') AS DAY_AFTER FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY 1) AS FIRST_LOGIN) SELECT ROUND(CAST(SUM(CASE WHEN NOT P.DAY_AFTER IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS A LEFT JOIN PLAYER_FIRST_LOGINS AS P ON P.PLAYER_ID = A.PLAYER_ID AND P.DAY_AFTER = A.EVENT_DATE;

/*
Prediction Result:
(1.0,)
*/