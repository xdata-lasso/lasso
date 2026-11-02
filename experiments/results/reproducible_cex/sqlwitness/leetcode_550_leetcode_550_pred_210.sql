-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (-1, '2023-01-01', 0, 0), (3, '2023-01-02', 6, 2), (-1, '2023-01-02', 6, 5), (1, '2023-01-01', 4, 6), (0, '2023-01-01', 2, 6), (0, '2023-01-02', 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH CONSECUTIVE AS (SELECT PLAYER_ID, DATE(MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID), '1 DAY') AS EVENT_DATE1 FROM ACTIVITY GROUP BY PLAYER_ID, EVENT_DATE) SELECT CAST(CAST(COUNT(DISTINCT B.PLAYER_ID) AS REAL) / COUNT(DISTINCT A.PLAYER_ID) AS REAL(5, 2)) AS FRACTION FROM ACTIVITY AS A LEFT JOIN CONSECUTIVE AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE = B.EVENT_DATE1;

/*
Prediction Result:
(0.5,)
*/