-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 10, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT COALESCE(ROUND(CAST((SELECT COUNT(DISTINCT A.PLAYER_ID) FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND CAST((JULIANDAY(B.EVENT_DATE) - JULIANDAY(A.EVENT_DATE)) AS INTEGER) = 1 JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM ACTIVITY GROUP BY 1) AS C ON A.PLAYER_ID = C.PLAYER_ID AND A.EVENT_DATE = C.FIRST_DATE) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2), 0) AS FRACTION;

/*
Prediction Result:
(1.0,)
*/