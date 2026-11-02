-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (14, '0998-09-25', NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('0998-09-25', 1, 0.0)
*/

-- Prediction Query
WITH FIRST_ACTIVITY AS (SELECT PLAYER_ID, EVENT_DATE AS INSTALL_DT FROM (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RANK_NUM FROM ACTIVITY) AS A WHERE RANK_NUM = 1) SELECT INSTALL_DT, COUNT(DISTINCT A.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(CASE WHEN EVENT_DATE - 1 = INSTALL_DT THEN A.PLAYER_ID END) AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS DAY1_RETENTION FROM ACTIVITY AS B LEFT JOIN FIRST_ACTIVITY AS A ON B.PLAYER_ID = A.PLAYER_ID GROUP BY INSTALL_DT;

/*
Prediction Result:
('0998-09-25', 1, 0.0)
*/