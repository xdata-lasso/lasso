-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 1, NULL), (0, '2023-01-02', 2, 2), (2, '2023-01-01', NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TB AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM ACTIVITY GROUP BY PLAYER_ID), TB1 AS (SELECT S.PLAYER_ID FROM TB AS F JOIN ACTIVITY AS S ON CAST((JULIANDAY(S.EVENT_DATE) - JULIANDAY(F.FIRST_DATE)) AS INTEGER) = 1 AND F.PLAYER_ID = S.PLAYER_ID) SELECT ROUND(CAST((SELECT COUNT(DISTINCT PLAYER_ID) FROM TB1) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM TB), 2) AS FRACTION;

/*
Prediction Result:
(0.5,)
*/