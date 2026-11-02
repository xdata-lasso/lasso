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
WITH TMP1 AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS ROW_INDEX FROM ACTIVITY), TMP2 AS (SELECT EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM TMP1 WHERE ROW_INDEX = 1 GROUP BY 1), TMP3 AS (SELECT T2.EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT T1.PLAYER_ID) AS DAY1_INSTALLS FROM (SELECT * FROM TMP1 WHERE ROW_INDEX = 2) AS T1 LEFT JOIN (SELECT * FROM TMP1 WHERE ROW_INDEX = 1) AS T2 ON T1.PLAYER_ID = T2.PLAYER_ID AND CAST((JULIANDAY(T1.EVENT_DATE) - JULIANDAY(T2.EVENT_DATE)) AS INTEGER) = 1 GROUP BY 1) SELECT TMP2.INSTALL_DT, TMP2.INSTALLS, CAST(COALESCE(CAST(TMP3.DAY1_INSTALLS * 1.0 AS REAL) / TMP2.INSTALLS, 0) AS REAL(10, 2)) AS DAY1_RETENTION FROM TMP2 LEFT JOIN TMP3 ON TMP2.INSTALL_DT = TMP3.INSTALL_DT;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/