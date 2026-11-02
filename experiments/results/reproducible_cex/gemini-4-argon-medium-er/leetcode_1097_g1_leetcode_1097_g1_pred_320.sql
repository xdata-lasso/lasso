-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_LOGIN, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY), TEMP2 AS (SELECT EVENT_DATE, COUNT(DISTINCT PLAYER_ID) AS TOTAL_INSTALLS, COUNT(DISTINCT IIF(CAST((JULIANDAY(NEXT_LOGIN) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1, PLAYER_ID, NULL)) AS NEXT_DAY_RETURN FROM CTE WHERE RNK = 1 GROUP BY 1 ORDER BY 1, EVENT_DATE NULLS LAST, TOTAL_INSTALLS NULLS LAST, NEXT_DAY_RETURN NULLS LAST) SELECT EVENT_DATE AS INSTALL_DT, TOTAL_INSTALLS AS INSTALLS, ROUND(CAST(NEXT_DAY_RETURN AS REAL) / TOTAL_INSTALLS, 2) AS DAY1_RETENTION FROM TEMP2 ORDER BY 1, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/