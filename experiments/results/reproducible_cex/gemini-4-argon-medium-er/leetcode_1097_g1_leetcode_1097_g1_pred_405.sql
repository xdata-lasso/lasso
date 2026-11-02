-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, NULL, 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2016-03-01', 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2017', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(None, 1, 0.0)
(2017, 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RANK FROM ACTIVITY) SELECT T1.EVENT_DATE AS INSTALL_DT, T1.INSTALLS, ROUND(CAST(T2.RETENT AS REAL) / T1.INSTALLS, 2) AS DAY1_RETENTION FROM (SELECT EVENT_DATE, COUNT(*) AS INSTALLS FROM CTE WHERE CTE.RANK = 1 GROUP BY EVENT_DATE) AS T1 JOIN (SELECT CTE.EVENT_DATE, SUM(CASE WHEN CTE.EVENT_DATE = ACTIVITY.EVENT_DATE - 1 THEN 1 ELSE 0 END) AS RETENT FROM CTE LEFT JOIN ACTIVITY ON CTE.PLAYER_ID = ACTIVITY.PLAYER_ID WHERE CTE.RANK = 1 GROUP BY CTE.EVENT_DATE) AS T2 ON T1.EVENT_DATE = T2.EVENT_DATE;

/*
Prediction Result:
(2017, 1, 0.0)
*/