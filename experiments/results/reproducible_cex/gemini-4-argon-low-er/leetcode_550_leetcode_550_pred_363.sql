-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_AND_SECOND_LOGINS AS (SELECT PLAYER_ID, EVENT_DATE FROM (SELECT ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RN, PLAYER_ID, EVENT_DATE FROM ACTIVITY) AS ORDERED_LOGINS WHERE RN <= 2), CONSECUTIVE_DAYS_MARKED AS (SELECT A.PLAYER_ID, A.EVENT_DATE AS FIRST_LOGIN, B.EVENT_DATE AS SECOND_LOGIN, CASE WHEN CAST((JULIANDAY(B.EVENT_DATE) - JULIANDAY(A.EVENT_DATE)) AS INTEGER) = 1 THEN 1 ELSE 0 END AS IS_CONSECUTIVE_DAYS FROM FIRST_AND_SECOND_LOGINS AS A LEFT JOIN FIRST_AND_SECOND_LOGINS AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE < B.EVENT_DATE) SELECT ROUND(CAST(SUM(IS_CONSECUTIVE_DAYS) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM CONSECUTIVE_DAYS_MARKED;

/*
Prediction Result:
(1.0,)
*/