-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY 1) SELECT COALESCE(ROUND(AVG(CASE WHEN A.EVENT_DATE IS NULL THEN 0 ELSE 1 END), 2), 0) AS FRACTION FROM CTE LEFT JOIN ACTIVITY AS A ON A.PLAYER_ID = CTE.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(CTE.FIRST_LOGIN)) AS INTEGER) = 1;

/*
Prediction Result:
(0,)
*/