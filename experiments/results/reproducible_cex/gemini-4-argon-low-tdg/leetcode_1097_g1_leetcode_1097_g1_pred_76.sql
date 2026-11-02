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
WITH TEMP1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY GROUP BY PLAYER_ID), TEMP2 AS (SELECT FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM TEMP1 GROUP BY FIRST_LOGIN), TEMP3 AS (SELECT B.FIRST_LOGIN, A.PLAYER_ID FROM ACTIVITY AS A JOIN TEMP1 AS B ON A.PLAYER_ID = B.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(B.FIRST_LOGIN)) AS INTEGER) = 1), TEMP4 AS (SELECT FIRST_LOGIN, COUNT(DISTINCT PLAYER_ID) AS NEXT_DAY FROM TEMP3 GROUP BY FIRST_LOGIN) SELECT B.INSTALL_DT, B.INSTALLS, ROUND(COALESCE((CAST(C.NEXT_DAY AS REAL) / B.INSTALLS), 0), 2) AS DAY1_RETENTION FROM TEMP2 AS B LEFT JOIN TEMP4 AS C ON B.INSTALL_DT = C.FIRST_LOGIN ORDER BY INSTALL_DT, B.INSTALL_DT NULLS LAST, B.INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2016-03-01', 2, 0.5)
('2016-06-25', 1, 0.0)
*/