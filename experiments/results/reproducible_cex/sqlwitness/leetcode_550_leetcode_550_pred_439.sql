-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', NULL, 0), (3, '2023-01-01', 0, 1), (-1, '2023-01-01', 3, 1), (1, '2023-01-01', 3, 1), (0, '2023-01-01', NULL, 2), (0, '2023-01-02', NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH TMP3 AS (SELECT COUNT(DISTINCT PLAYER_ID) AS TOTAL FROM ACTIVITY), TMP4 AS (WITH TMP2 AS (WITH TMP AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1, EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NXT FROM ACTIVITY) SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE, MIN(NXT) AS NXT FROM TMP GROUP BY PLAYER_ID) SELECT COUNT(PLAYER_ID) AS CNT FROM TMP2 WHERE CAST((JULIANDAY(NXT) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1) SELECT ROUND(CAST(CNT AS REAL) / TOTAL, 2) AS FRACTION FROM TMP4 INNER JOIN TMP3 ON TRUE;

/*
Prediction Result:
(0.2,)
*/