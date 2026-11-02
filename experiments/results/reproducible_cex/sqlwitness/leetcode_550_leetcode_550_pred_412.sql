-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (0, '2023-01-01', -1, 1), (1, '2023-01-02', 2, 2), (3, '2023-01-01', -1, 1), (1, '2023-01-01', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(W.TARGET_PLAYERS AS REAL) / Z.TOTAL_PLAYERS, 2) AS FRACTION FROM (SELECT COUNT(*) AS TARGET_PLAYERS FROM (SELECT *, DATE(X.FIRST_LOGIN, '1 DAY') AS NEXT_DAY FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS X) AS Y JOIN ACTIVITY AS A ON Y.PLAYER_ID = A.PLAYER_ID AND Y.NEXT_DAY = A.EVENT_DATE) AS W CROSS JOIN (SELECT COUNT(*) AS TOTAL_PLAYERS FROM (SELECT DISTINCT (PLAYER_ID) FROM ACTIVITY) AS U) AS Z;

/*
Prediction Result:
(0.33,)
*/