-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT T1.PLAYER_ID) AS REAL) / T2.TOTAL_PLAYERS, 2) AS FRACTION FROM (SELECT A.PLAYER_ID, A.EVENT_DATE FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B CROSS JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS LOGIN_1ST FROM ACTIVITY GROUP BY PLAYER_ID) AS C WHERE A.PLAYER_ID = B.PLAYER_ID AND ABS(CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(B.EVENT_DATE)) AS INTEGER)) = 1 AND A.PLAYER_ID = C.PLAYER_ID AND A.EVENT_DATE = C.LOGIN_1ST) AS T1 CROSS JOIN (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL_PLAYERS FROM ACTIVITY) AS T2;

/*
Prediction Result:
(None,)
*/