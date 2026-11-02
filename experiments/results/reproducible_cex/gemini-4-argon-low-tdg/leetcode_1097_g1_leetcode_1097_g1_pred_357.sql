-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic retention, fractional rounding (1/3 = 0.33), and non-install days vs install days using integer dates.
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, 100, 1, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, 101, 1, 2);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, 100, 2, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (2, 102, 2, 4);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (3, 100, 3, 1);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, 101, 4, 3);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (4, 102, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(100, 3, 0.33)
(101, 1, 1.0)
*/

-- Prediction Query
WITH T1 AS (SELECT A.EVENT_DATE, SUM(CASE WHEN B.GAMES_PLAYED > 0 THEN 1 ELSE 0 END) AS DAY1_COUNT FROM ACTIVITY AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID WHERE DATE(A.EVENT_DATE, '1 DAY') = B.EVENT_DATE AND (A.PLAYER_ID, A.EVENT_DATE) IN (SELECT PLAYER_ID, MIN(EVENT_DATE) FROM ACTIVITY GROUP BY PLAYER_ID) GROUP BY A.EVENT_DATE), T2 AS (SELECT INSTALL_DT, COUNT(*) AS INSTALLS FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) AS A GROUP BY INSTALL_DT) SELECT T2.*, ROUND((CASE WHEN T1.DAY1_COUNT > 0 THEN CAST(T1.DAY1_COUNT AS REAL) / T2.INSTALLS ELSE 0.0 END), 2) AS DAY1_RETENTION FROM T2 LEFT JOIN T1 ON T2.INSTALL_DT = T1.EVENT_DATE;

/*
Prediction Result:
(100, 3, 0.0)
(101, 1, 0.0)
*/