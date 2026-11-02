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
SELECT ROUND(CAST(COUNT(A1.PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT (A3.PLAYER_ID)) FROM ACTIVITY AS A3), 2) AS FRACTION FROM ACTIVITY AS A1 CROSS JOIN ACTIVITY AS A2 WHERE A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE <> A2.EVENT_DATE AND CAST((JULIANDAY(A2.EVENT_DATE) - JULIANDAY(A1.EVENT_DATE)) AS INTEGER) = 1 AND (A1.PLAYER_ID, A1.EVENT_DATE) IN (SELECT A3.PLAYER_ID, MIN(A3.EVENT_DATE) FROM ACTIVITY AS A3 GROUP BY 1);

/*
Prediction Result:
(0.33,)
*/