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
WITH CTE AS (SELECT *, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RK FROM ACTIVITY) SELECT DISTINCT C.MIN_DT AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(DATE_1) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM ((SELECT A.PLAYER_ID, A.MIN_DT, B.SEC_DT, CASE WHEN ABS(CAST((JULIANDAY(A.MIN_DT) - JULIANDAY(B.SEC_DT)) AS INTEGER)) = 1 THEN 1 ELSE 0 END AS DATE_1 FROM (SELECT DISTINCT PLAYER_ID, EVENT_DATE AS MIN_DT FROM CTE WHERE RK = 1) AS A LEFT JOIN (SELECT DISTINCT PLAYER_ID, EVENT_DATE AS SEC_DT FROM CTE WHERE RK = 2) AS B ON A.PLAYER_ID = B.PLAYER_ID)) AS C GROUP BY 1;

/*
Prediction Result:
('1973-03-12', 1, 1.0)
*/