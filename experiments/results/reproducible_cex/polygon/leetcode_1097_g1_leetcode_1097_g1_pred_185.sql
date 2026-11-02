-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (79, '0998-09-25', -464, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (13, '0998-09-24', -464, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('0998-09-24', 1, 0.0)
('0998-09-25', 1, 0.0)
*/

-- Prediction Query
WITH RETENTION AS (SELECT PLAYER_ID, INSTALL_DT FROM (SELECT PLAYER_ID, EVENT_DATE, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS INSTALL_DT FROM ACTIVITY) AS T WHERE EVENT_DATE - INSTALL_DT = 1), INSTALL_DATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) SELECT A.INSTALL_DT, COUNT(A.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(B.PLAYER_ID) AS REAL) / COUNT(A.PLAYER_ID), 2) AS DAY1_RETENTION FROM INSTALL_DATE AS A LEFT JOIN RETENTION AS B ON A.PLAYER_ID = B.PLAYER_ID GROUP BY A.INSTALL_DT;

/*
Prediction Result:
('0998-09-24', 1, 0.0)
('0998-09-25', 1, 0.0)
*/