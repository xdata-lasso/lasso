-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT PLAYER_ID, EVENT_DATE FROM (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RANK_1 FROM ACTIVITY) AS T1 WHERE RANK_1 = 1) SELECT ROUND(CAST(SUM(CASE WHEN A.EVENT_DATE = DATE(B.EVENT_DATE, '1 DAY') THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS A LEFT JOIN FIRST_LOGIN AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE <> B.EVENT_DATE;

/*
Prediction Result:
(1.0,)
*/