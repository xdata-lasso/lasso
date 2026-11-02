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
WITH TEMP AS (SELECT A.PLAYER_ID, A.EVENT_DATE FROM ACTIVITY AS A JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID WHERE A.EVENT_DATE >= B.EVENT_DATE GROUP BY A.PLAYER_ID, A.EVENT_DATE HAVING COUNT(B.EVENT_DATE) = 1), TEMP1 AS (SELECT TEMP.PLAYER_ID, TEMP.EVENT_DATE, CASE WHEN A.EVENT_DATE IS NULL THEN 0 ELSE 1 END AS RETENT FROM TEMP LEFT JOIN ACTIVITY AS A ON TEMP.PLAYER_ID = A.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(TEMP.EVENT_DATE)) AS INTEGER) = 1) SELECT EVENT_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(RETENT) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM TEMP1 GROUP BY EVENT_DATE ORDER BY INSTALL_DT, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/