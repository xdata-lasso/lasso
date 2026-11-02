-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH DF AS (SELECT PLAYER_ID, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS LEAD_D, EVENT_DATE, CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC))) AS INTEGER) AS DTDF FROM ACTIVITY), FIRST_LOG AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS MN_DT FROM ACTIVITY GROUP BY 1) SELECT ROUND(CAST(COUNT(DISTINCT FL.PLAYER_ID) AS REAL) / (SELECT COUNT(DISTINCT PLAYER_ID) FROM DF), 2) AS FRACTION FROM DF JOIN FIRST_LOG AS FL ON FL.PLAYER_ID = DF.PLAYER_ID AND MN_DT = DF.EVENT_DATE WHERE DTDF = -1;

/*
Prediction Result:
(1.0,)
*/