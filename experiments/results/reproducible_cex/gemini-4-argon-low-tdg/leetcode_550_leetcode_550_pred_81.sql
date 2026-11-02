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
WITH FIRST_LOGIN AS (SELECT A.PLAYER_ID, A.EVENT_DATE FROM ACTIVITY AS A JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY 1) AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE = DATE(B.FIRST_LOGIN, '1 DAY')) SELECT ROUND(CAST(COUNT(DISTINCT PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM FIRST_LOGIN;

/*
Prediction Result:
(0.33,)
*/