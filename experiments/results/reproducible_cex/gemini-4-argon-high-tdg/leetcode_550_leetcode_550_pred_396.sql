-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20230501, 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20230502, 2, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20230501, 3, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20230510, 1, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20230512, 4, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.33,)
*/

-- Prediction Query
WITH FIRST_LOGINS AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID), NEXT_DAYS AS (SELECT PLAYER_ID, DATE(FIRST_LOGIN, '1 DAY') AS NEXT_DAY FROM FIRST_LOGINS), CONSEC_PLAYERS AS (SELECT COUNT(DISTINCT A.PLAYER_ID) AS CONSEC_PLAYER_COUNT FROM ACTIVITY AS A INNER JOIN NEXT_DAYS AS N ON A.PLAYER_ID = N.PLAYER_ID AND A.EVENT_DATE = N.NEXT_DAY), UNIQUE_PLAYERS AS (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL_PLAYER_COUNT FROM ACTIVITY) SELECT ROUND(CAST(CONSEC_PLAYER_COUNT AS REAL) / TOTAL_PLAYER_COUNT, 2) AS FRACTION FROM UNIQUE_PLAYERS CROSS JOIN CONSEC_PLAYERS;

/*
Prediction Result:
(0.0,)
*/