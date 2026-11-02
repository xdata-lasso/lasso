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
WITH INSTALL_ACTIVITY AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY PLAYER_ID), COUNT_RETENTION AS (SELECT IACT.INSTALL_DATE AS INSTALL_DATE, COUNT(ACT.PLAYER_ID) AS CNT FROM ACTIVITY AS ACT JOIN INSTALL_ACTIVITY AS IACT ON ACT.PLAYER_ID = IACT.PLAYER_ID AND ACT.EVENT_DATE = DATE(IACT.INSTALL_DATE, '1 DAY') GROUP BY INSTALL_DATE) SELECT IA.INSTALL_DATE AS INSTALL_DT, COUNT(IA.INSTALL_DATE) AS INSTALLS, ROUND(CAST(COALESCE(CR.CNT, 0) AS REAL) / COUNT(IA.INSTALL_DATE), 2) AS DAY1_RETENTION FROM INSTALL_ACTIVITY AS IA LEFT JOIN COUNT_RETENTION AS CR ON IA.INSTALL_DATE = CR.INSTALL_DATE GROUP BY INSTALL_DT;

/*
Prediction Result:
(100, 3, 0.0)
(101, 1, 0.0)
*/