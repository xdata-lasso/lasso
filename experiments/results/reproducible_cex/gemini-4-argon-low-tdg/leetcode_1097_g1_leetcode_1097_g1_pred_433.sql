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
WITH T1 AS (SELECT A.*, B.EVENT_DATE AS NEXT_DAY, B.GAMES_PLAYED AS NEXT_DAY_GAMES_PLAYED FROM ACTIVITY AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE = DATE(B.EVENT_DATE, '-1 DAY')), T2 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM T1 GROUP BY 1), T3 AS (SELECT A.*, B.NEXT_DAY FROM T2 AS A LEFT JOIN T1 AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.INSTALL_DT = B.EVENT_DATE), T4 AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM T2 GROUP BY 1), T5 AS (SELECT INSTALL_DT, COUNT(*) AS RETENTION FROM T3 WHERE NOT NEXT_DAY IS NULL GROUP BY 1) SELECT A.*, COALESCE(ROUND((CAST(B.RETENTION AS REAL) / A.INSTALLS), 2), 0.00) AS DAY1_RETENTION FROM T4 AS A LEFT JOIN T5 AS B ON A.INSTALL_DT = B.INSTALL_DT;

/*
Prediction Result:
(100, 3, 0.0)
(101, 1, 0.0)
*/