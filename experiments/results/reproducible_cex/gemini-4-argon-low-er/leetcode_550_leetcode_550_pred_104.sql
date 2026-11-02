-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2017-01-01', 3, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2016-01-01', 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH ROW_NBR AS (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RN FROM ACTIVITY), FIRST_LOGIN AS (SELECT PLAYER_ID, EVENT_DATE AS FIRST_DT FROM ROW_NBR WHERE RN = 1), SECOND_LOGIN AS (SELECT PLAYER_ID, EVENT_DATE AS SECOND_DT FROM ROW_NBR WHERE RN = 2) SELECT ROUND(AVG(IF_CONT), 2) AS FRACTION FROM (SELECT F.PLAYER_ID, F.FIRST_DT, (CASE WHEN (S.SECOND_DT - F.FIRST_DT) = 1 THEN 1 ELSE 0 END) AS IF_CONT FROM FIRST_LOGIN AS F LEFT JOIN SECOND_LOGIN AS S ON F.PLAYER_ID = S.PLAYER_ID) AS TMP;

/*
Prediction Result:
(0.5,)
*/