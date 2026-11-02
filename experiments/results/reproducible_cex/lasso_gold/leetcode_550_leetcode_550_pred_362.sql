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
WITH CTE AS (SELECT A.*, D1.DAY1 FROM (SELECT DISTINCT PLAYER_ID, MIN(EVENT_DATE) AS DAY1 FROM ACTIVITY GROUP BY 1 ORDER BY 1, PLAYER_ID NULLS LAST, DAY1 NULLS LAST) AS D1 JOIN ACTIVITY AS A ON D1.PLAYER_ID = A.PLAYER_ID) SELECT ROUND(CAST(COUNT(DISTINCT (CASE WHEN EVENT_DATE - DAY1 = 1 THEN PLAYER_ID ELSE NULL END)) AS REAL) / COUNT(DISTINCT PLAYER_ID), 2) AS FRACTION FROM CTE;

/*
Prediction Result:
(1.0,)
*/