-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20230801, 5, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20230802, 5, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20230804, 6, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TEMP AS (SELECT COUNT(DISTINCT PLAYER_ID) AS NUM_LOGGED FROM (SELECT *, EVENT_DATE - LAG(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS DIFF, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS ROW_NUM FROM ACTIVITY) AS T WHERE NOT DIFF IS NULL AND DIFF = 1 AND ROW_NUM <= 2 GROUP BY DIFF) SELECT ROUND(CAST(NUM_LOGGED AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM ACTIVITY), 2) AS FRACTION FROM TEMP;

/*
Prediction Result:
*/