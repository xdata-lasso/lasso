-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ISO string dates (e.g. '2016-03-01') to catch mutants differing in date addition vs integer addition, plus 0% and 50% retention.
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, '2016-06-25', 1, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2016-03-01', 3, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, '2016-07-03', 3, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 2, 0.0)
('2016-06-25', 1, 0.0)
*/

-- Prediction Query
WITH CTE_1 AS (SELECT PLAYER_ID, EVENT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS PLAYER_SEQ, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_DATE FROM ACTIVITY), CTE_2 AS (SELECT EVENT_DATE AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM CTE_1 WHERE PLAYER_SEQ = 1 GROUP BY EVENT_DATE), CTE_3 AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS RETENTION_COUNT FROM CTE_1 WHERE PLAYER_SEQ = 1 AND CAST((JULIANDAY(NEXT_DATE) - JULIANDAY(EVENT_DATE)) AS INTEGER) = 1 GROUP BY EVENT_DATE) SELECT A.INSTALL_DT, A.INSTALLS, ROUND(CAST(COALESCE(B.RETENTION_COUNT, 0) * 1.0 AS REAL) / A.INSTALLS, 2) AS DAY1_RETENTION FROM CTE_2 AS A LEFT JOIN CTE_3 AS B ON A.INSTALL_DT = B.EVENT_DATE;

/*
Prediction Result:
('2016-03-01', 2, 0.5)
('2016-06-25', 1, 0.0)
*/