-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1166, '1973-03-12', 1168, 1169);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1166, '1973-03-13', 1158, 1159);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('1973-03-12', 1, 0.0)
*/

-- Prediction Query
WITH CTE1 AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS INSTALLS FROM (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RANKING FROM ACTIVITY) AS SUB WHERE RANKING = 1 GROUP BY EVENT_DATE), CTE2 AS (SELECT EVENT_DATE, COUNT(DISTINCT PLAYER_ID) AS CNT_LOGGED_BACK_NEXT_DAY FROM (SELECT PLAYER_ID, EVENT_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS EVENT_DATE_LEAD, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RANKING FROM ACTIVITY) AS SUB WHERE CAST((JULIANDAY(EVENT_DATE_LEAD) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1 AND RANKING = 1 GROUP BY EVENT_DATE) SELECT D1.EVENT_DATE AS INSTALL_DT, D1.INSTALLS, ROUND(CAST(COALESCE(D2.CNT_LOGGED_BACK_NEXT_DAY, 0) AS REAL) / D1.INSTALLS, 2) AS DAY1_RETENTION FROM CTE1 AS D1 LEFT JOIN CTE2 AS D2 ON D1.EVENT_DATE = D2.EVENT_DATE;

/*
Prediction Result:
('1973-03-12', 1, 1.0)
*/