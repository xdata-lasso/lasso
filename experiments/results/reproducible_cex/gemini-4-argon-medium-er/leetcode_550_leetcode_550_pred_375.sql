-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(AVG(FINAL), 2) AS FRACTION FROM (SELECT C.PLAYER_ID, MAX(YES) AS FINAL FROM (SELECT A.PLAYER_ID, CASE WHEN CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(B.FIRST)) AS INTEGER) = 1 THEN 1 ELSE 0 END AS YES FROM ACTIVITY AS A LEFT JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST FROM ACTIVITY GROUP BY PLAYER_ID) AS B ON A.PLAYER_ID = B.PLAYER_ID) AS C GROUP BY C.PLAYER_ID) AS D;

/*
Prediction Result:
(1.0,)
*/