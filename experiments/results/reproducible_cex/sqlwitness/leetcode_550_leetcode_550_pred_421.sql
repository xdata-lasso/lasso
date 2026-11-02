-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-01', 0, 3), (0, '2023-01-01', 1, 1), (3, '2023-01-02', 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH FIRST_LOGINS AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_EVENT_DATE FROM ACTIVITY GROUP BY 1) SELECT ROUND(CAST(A.NUM_PLAYERS_LOGGED_IN_NEXT_DAY AS REAL) / B.TOTAL_NUM_PLAYERS, 2) AS FRACTION FROM (SELECT COUNT(DISTINCT ACTIVITY.PLAYER_ID) AS NUM_PLAYERS_LOGGED_IN_NEXT_DAY FROM FIRST_LOGINS INNER JOIN ACTIVITY ON FIRST_LOGINS.PLAYER_ID = ACTIVITY.PLAYER_ID AND DATE(FIRST_LOGINS.FIRST_EVENT_DATE, '1 DAY') = DATE(ACTIVITY.EVENT_DATE)) AS A CROSS JOIN (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL_NUM_PLAYERS FROM ACTIVITY) AS B;

/*
Prediction Result:
(0.5,)
*/