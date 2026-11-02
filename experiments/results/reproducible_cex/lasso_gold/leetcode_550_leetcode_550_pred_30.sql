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
SELECT ROUND(CAST(COUNT(DISTINCT (CASE WHEN NOT B.PLAYER_ID IS NULL THEN B.PLAYER_ID END)) AS REAL) / COUNT(*), 2) AS FRACTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_EVENT FROM ACTIVITY GROUP BY PLAYER_ID) AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.FIRST_EVENT = DATE(B.EVENT_DATE, '-1 DAY');

/*
Prediction Result:
(0.0,)
*/