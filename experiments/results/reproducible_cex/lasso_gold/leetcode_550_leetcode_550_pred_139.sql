-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1001, 10, 1003, 1005);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1001, 11, 1010.0, 1014.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(1.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(COUNT(DISTINCT A.PLAYER_ID) AS REAL) / COUNT(DISTINCT T.PLAYER_ID), 2) AS FRACTION FROM (SELECT PLAYER_ID, DATE(MIN(EVENT_DATE), '1 DAY') AS NEXT_DAY FROM ACTIVITY GROUP BY PLAYER_ID) AS T LEFT JOIN ACTIVITY AS A ON T.PLAYER_ID = A.PLAYER_ID AND T.NEXT_DAY = A.EVENT_DATE;

/*
Prediction Result:
(0.0,)
*/