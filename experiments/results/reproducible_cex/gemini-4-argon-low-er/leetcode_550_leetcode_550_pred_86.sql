-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
WITH SUB AS (SELECT * FROM (SELECT PLAYER_ID, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK, EVENT_DATE FROM ACTIVITY) AS TMP WHERE RNK IN (1, 2)), CNT AS (SELECT COUNT(DISTINCT PLAYER_ID) AS CNT FROM ACTIVITY) SELECT ROUND(CAST(COUNT(S1.PLAYER_ID) AS REAL) / CNT, 2) AS FRACTION FROM SUB AS S1 JOIN SUB AS S2 USING (PLAYER_ID) CROSS JOIN CNT WHERE CAST((JULIANDAY(S2.EVENT_DATE) - JULIANDAY(S1.EVENT_DATE)) AS INTEGER) = 1;

/*
Prediction Result:
(1.0,)
*/