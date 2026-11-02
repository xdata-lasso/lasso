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
WITH CTE AS (SELECT *, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_LOGIN, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RNK FROM ACTIVITY), CTE2 AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS TOTAL_LOGINS, SUM(CAST((JULIANDAY(NEXT_LOGIN) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1) AS REPEAT_LOGINS FROM CTE WHERE RNK = 1 GROUP BY EVENT_DATE) SELECT EVENT_DATE AS INSTALL_DT, TOTAL_LOGINS AS INSTALLS, COALESCE(ROUND(CAST(REPEAT_LOGINS AS REAL) / TOTAL_LOGINS, 2), 0) AS DAY1_RETENTION FROM CTE2 GROUP BY 1, 2, 3;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/