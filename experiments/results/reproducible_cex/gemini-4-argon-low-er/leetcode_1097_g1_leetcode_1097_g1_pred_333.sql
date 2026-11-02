-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NUM FROM ACTIVITY), CTE2 AS (SELECT CTE1.PLAYER_ID, CTE1.EVENT_DATE, CTE.EVENT_DATE AS DAYAFTER FROM (SELECT PLAYER_ID, EVENT_DATE FROM CTE WHERE NUM = 1) AS CTE1 LEFT JOIN CTE ON CTE1.PLAYER_ID = CTE.PLAYER_ID AND CAST((JULIANDAY(CTE.EVENT_DATE) - JULIANDAY(CTE1.EVENT_DATE)) AS INTEGER) = 1) SELECT A.EVENT_DATE AS INSTALL_DT, DEN AS INSTALLS, ROUND(CAST(COALESCE(B.NUM, 0) AS REAL) / A.DEN, 2) AS DAY1_RETENTION FROM (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS DEN FROM CTE2 GROUP BY EVENT_DATE) AS A LEFT JOIN (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS NUM FROM (SELECT * FROM CTE2 WHERE NOT DAYAFTER IS NULL) AS C GROUP BY EVENT_DATE) AS B ON A.EVENT_DATE = B.EVENT_DATE;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/