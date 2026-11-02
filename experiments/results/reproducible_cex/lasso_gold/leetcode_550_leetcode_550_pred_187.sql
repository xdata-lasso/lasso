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
SELECT ROUND(CAST(SUM(CASE WHEN T1.EVENT_DATE - T2.FIRST_DATE = 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(DISTINCT T1.PLAYER_ID), 2) AS FRACTION FROM ACTIVITY AS T1 INNER JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS T2 ON T1.PLAYER_ID = T2.PLAYER_ID;

/*
Prediction Result:
(1.0,)
*/