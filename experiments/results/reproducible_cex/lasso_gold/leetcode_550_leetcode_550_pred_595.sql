-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1023, '1971-02-02', 1025, 1027);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1023, '1972-03-03', 1025, 1027);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT ROUND((CAST(SUM(CASE WHEN (temp.min_date + 1) = a.event_date THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT temp.player_id)), 2) AS fraction FROM (SELECT player_id, MIN(event_date) AS min_date FROM activity GROUP BY player_id) AS temp JOIN activity AS a ON temp.player_id = a.player_id;

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT ROUND(CAST(SUM(CASE WHEN NEW.EVENT_DATE2 IS NULL THEN 0 ELSE 1 END) AS REAL) / COUNT(DISTINCT NEW.PLAYER_ID), 2) AS FRACTION FROM (SELECT A1.PLAYER_ID, A1.EVENT_DATE AS EVENT_DATE1, A2.EVENT_DATE AS EVENT_DATE2, ROW_NUMBER() OVER (PARTITION BY A1.PLAYER_ID ORDER BY A1.EVENT_DATE ASC) AS R FROM ACTIVITY AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND A2.EVENT_DATE - A1.EVENT_DATE = 1) AS NEW WHERE NEW.R = 1;

/*
Prediction Result:
(1.0,)
*/