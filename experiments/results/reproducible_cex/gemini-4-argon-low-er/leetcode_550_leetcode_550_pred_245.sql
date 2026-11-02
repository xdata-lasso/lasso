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
WITH FIRST_LOGIN_INFO AS (SELECT PLAYER_ID, DATE(MIN(EVENT_DATE), '1 DAY') AS SECOND_DAY FROM ACTIVITY GROUP BY PLAYER_ID), SECOND_LOGIN AS (SELECT MAX(CASE WHEN EVENT_DATE = SECOND_DAY THEN 1 ELSE 0 END) AS FLAG FROM ACTIVITY AS A LEFT JOIN FIRST_LOGIN_INFO AS B ON A.PLAYER_ID = B.PLAYER_ID GROUP BY A.PLAYER_ID) SELECT ROUND(AVG(FLAG), 2) AS FRACTION FROM SECOND_LOGIN;

/*
Prediction Result:
(1.0,)
*/