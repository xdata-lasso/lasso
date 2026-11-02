-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(A.PLAYER_ID) AS REAL) / (SELECT COUNT(1) FROM (SELECT DISTINCT PLAYER_ID FROM ACTIVITY) AS TBL), 2) AS FRACTION FROM (SELECT DISTINCT PLAYER_ID, DATE(MIN(EVENT_DATE), '1 DAY') AS TEST_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS A CROSS JOIN (SELECT PLAYER_ID, TEST_DATE FROM (SELECT PLAYER_ID, EVENT_DATE AS TEST_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS MIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID, EVENT_DATE) AS X WHERE TEST_DATE > MIN_DATE) AS B WHERE A.PLAYER_ID = B.PLAYER_ID AND A.TEST_DATE = B.TEST_DATE;

/*
Prediction Result:
(1.0,)
*/