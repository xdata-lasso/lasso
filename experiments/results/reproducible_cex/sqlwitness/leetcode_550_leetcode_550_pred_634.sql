-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 1, NULL), (0, '2023-01-01', 1, 1), (0, '2023-01-02', NULL, 2), (1, '2023-01-02', -1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CURRENT_LOGS AS (SELECT A.PLAYER_ID, (SELECT EVENT_DATE FROM ACTIVITY WHERE PLAYER_ID = A.PLAYER_ID ORDER BY EVENT_DATE ASC, ACTIVITY.player_id NULLS LAST LIMIT 1) AS FIRST_LOGIN FROM (SELECT DISTINCT PLAYER_ID FROM ACTIVITY) AS A), RESULTS AS (SELECT CL.PLAYER_ID, IIF((SELECT COUNT(EVENT_DATE) FROM ACTIVITY WHERE PLAYER_ID = CL.PLAYER_ID AND EVENT_DATE BETWEEN CL.FIRST_LOGIN AND DATE(FIRST_LOGIN, '1 DAY')) = 2, 'YES', 'NO') AS CONSECUTIVE_LOGIN FROM CURRENT_LOGS AS CL ORDER BY CL.PLAYER_ID ASC, CONSECUTIVE_LOGIN NULLS LAST) SELECT ROUND(CAST(COUNT(R.PLAYER_ID) AS REAL) / (SELECT COUNT(PLAYER_ID) FROM RESULTS), 2) AS FRACTION FROM RESULTS AS R WHERE R.CONSECUTIVE_LOGIN = 'YES';

/*
Prediction Result:
(0.33,)
*/