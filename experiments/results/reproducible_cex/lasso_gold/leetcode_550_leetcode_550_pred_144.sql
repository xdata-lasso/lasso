-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1021, 10, 1013, 1015);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1022, '1970-01-01', 1013, 1015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT A.PLAYER_ID) AS REAL) / COUNT(DISTINCT B.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS A CROSS JOIN ACTIVITY AS B CROSS JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID) AS TEMP WHERE CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(TEMP.FIRST_LOGIN)) AS INTEGER) = 1 AND A.PLAYER_ID = TEMP.PLAYER_ID;

/*
Prediction Result:
(None,)
*/