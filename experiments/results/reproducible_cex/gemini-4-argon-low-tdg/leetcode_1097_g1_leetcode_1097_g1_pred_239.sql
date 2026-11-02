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
WITH CTE1 AS (SELECT MIN(EVENT_DATE) AS INSTALL_DT, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID), CTE2 AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM CTE1 GROUP BY INSTALL_DT), CTE3 AS (SELECT CTE1.PLAYER_ID, INSTALL_DT, DATE(INSTALL_DT, '1 DAY') AS SECOND_DAY FROM CTE1), CTE4 AS (SELECT CTE3.PLAYER_ID, CTE3.INSTALL_DT FROM CTE3 JOIN ACTIVITY AS A ON CTE3.PLAYER_ID = A.PLAYER_ID AND CTE3.SECOND_DAY = A.EVENT_DATE), CTE5 AS (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS NUM1 FROM CTE4 GROUP BY INSTALL_DT) SELECT CTE2.INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(NUM1, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM CTE2 LEFT JOIN CTE5 ON CTE2.INSTALL_DT = CTE5.INSTALL_DT;

/*
Prediction Result:
(100, 3, 0.0)
(101, 1, 0.0)
*/