-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-02', 2, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2017-06-25', 3, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2016-03-02', 1, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2018-07-03', 4, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TOTAL_PLAYER AS (SELECT COUNT(DISTINCT PLAYER_ID) AS NUMBER_OF_PLAYER FROM ACTIVITY), FIRST_LOGIN AS (SELECT PLAYER_ID, EVENT_DATE AS FIRST_DATE FROM (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS TEMP WHERE RNK = 1), SECOND_LOGIN AS (SELECT F.PLAYER_ID FROM FIRST_LOGIN AS F JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(F.FIRST_DATE)) AS INTEGER) = 1), SECOND_PLAYER AS (SELECT COUNT(DISTINCT PLAYER_ID) AS NUMBER_OF_SECOND FROM SECOND_LOGIN) SELECT ROUND(CAST(NUMBER_OF_SECOND AS REAL) / (SELECT NUMBER_OF_PLAYER FROM TOTAL_PLAYER), 2) AS FRACTION FROM SECOND_PLAYER;

/*
Prediction Result:
(0.33,)
*/