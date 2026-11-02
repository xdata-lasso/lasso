-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', NULL, NULL), (-1, '2023-01-01', 1, 2), (3, '2023-01-02', 3, 0), (1, '2023-01-02', NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TOTAL_NUM AS (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL FROM ACTIVITY), FIRST_DAY AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRSTDAY FROM ACTIVITY GROUP BY PLAYER_ID), NUM_PLAYERS AS (SELECT COUNT(DISTINCT A.PLAYER_ID) AS NUM FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B CROSS JOIN FIRST_DAY WHERE A.EVENT_DATE = DATE(B.EVENT_DATE, '-1 day') AND A.PLAYER_ID = B.PLAYER_ID AND A.PLAYER_ID = FIRST_DAY.PLAYER_ID AND A.EVENT_DATE = FIRST_DAY.FIRSTDAY) SELECT ROUND(CAST(NUM_PLAYERS.NUM AS REAL) / TOTAL_NUM.TOTAL, 2) AS FRACTION FROM TOTAL_NUM CROSS JOIN NUM_PLAYERS;

/*
Prediction Result:
(0.33,)
*/