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
WITH ACTIVITYRANK AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1, NULL) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS EVENT_RANK FROM ACTIVITY), TOTAL_PLAYERS AS (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL_PLAYERS FROM ACTIVITY) SELECT ROUND(CAST(COUNT(A.PLAYER_ID) AS REAL) / TOTAL_PLAYERS, 2) AS FRACTION FROM ACTIVITYRANK AS A CROSS JOIN TOTAL_PLAYERS AS T WHERE EVENT_RANK = 1 AND CAST((JULIANDAY(NEXT_EVENT_DATE) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1;

/*
Prediction Result:
(0.33,)
*/