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
WITH TEMP AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY 1) SELECT ROUND(CAST(COUNT(DISTINCT Y.PLAYER_ID) AS REAL) / COUNT(DISTINCT X.PLAYER_ID), 2) AS FRACTION FROM TEMP AS X LEFT JOIN ACTIVITY AS Y ON X.PLAYER_ID = Y.PLAYER_ID AND CAST((JULIANDAY(X.EVENT_DATE) - JULIANDAY(Y.EVENT_DATE)) AS INTEGER) = -1;

/*
Prediction Result:
(0.0,)
*/