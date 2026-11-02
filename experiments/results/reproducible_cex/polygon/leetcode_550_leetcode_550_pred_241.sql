-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (18, '0998-01-10', 22, NULL);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (18, '0998-01-09', 23, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT DISTINCT A1.PLAYER_ID, A1.EVENT_DATE AS LOGIN_DATE, A2.EVENT_DATE AS NEXT_LOGIN FROM ACTIVITY AS A1 JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE + 1 = A2.EVENT_DATE), CTE2 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY AS A GROUP BY PLAYER_ID), CTE3 AS (SELECT DISTINCT CTE2.PLAYER_ID FROM CTE1 JOIN CTE2 ON CTE1.PLAYER_ID = CTE2.PLAYER_ID AND CTE1.LOGIN_DATE = CTE2.FIRST_LOGIN) SELECT ROUND(CAST(COUNT(*) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM CTE3;

/*
Prediction Result:
(0.0,)
*/