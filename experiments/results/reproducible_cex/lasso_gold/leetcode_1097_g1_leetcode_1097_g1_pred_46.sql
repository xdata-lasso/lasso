-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-1, '1972-12-30', 1096, 1097);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (-1, '1973-01-02', 1099, 1100);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1103, '1973-01-06', 1099, 1100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('1972-12-30', 1, 0.0)
('1973-01-06', 1, 0.0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS PREV_DAY, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RANK_INDEX FROM ACTIVITY), CTE2 AS (SELECT EVENT_DATE, COUNT(DISTINCT PLAYER_ID) AS DR FROM CTE1 WHERE RANK_INDEX = 1 AND (PREV_DAY - EVENT_DATE) = 1 GROUP BY EVENT_DATE) SELECT TMP.EVENT_DATE AS INSTALL_DT, INSTALLS, IIF(DR IS NULL, 0.00, ROUND(CAST(DR AS REAL) / INSTALLS, 2)) AS DAY1_RETENTION FROM (SELECT EVENT_DATE, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM CTE1 WHERE RANK_INDEX = 1 GROUP BY EVENT_DATE) AS TMP LEFT JOIN CTE2 ON TMP.EVENT_DATE = CTE2.EVENT_DATE;

/*
Prediction Result:
('1972-12-30', 1, 1.0)
('1973-01-06', 1, 0.0)
*/