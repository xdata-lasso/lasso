-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 10, 1089, 1091);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 11, 1096.0, 1100.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 10, 1093, 1095);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, 11, 1100.0, 1104.0);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1098, '1981-01-12', 1100.0, 1104.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(10, 0, None)
('1981-01-12', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT MIN(EVENT_DATE) AS E_DATE, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID) SELECT E_DATE AS INSTALL_DT, COUNT(DISTINCT A.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(DISTINCT CASE WHEN EVENT_DATE = E_DATE + 1 THEN A.PLAYER_ID END) AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS DAY1_RETENTION FROM ACTIVITY AS A CROSS JOIN CTE AS B WHERE A.PLAYER_ID = B.PLAYER_ID GROUP BY 1;

/*
Prediction Result:
('1981-01-12', 1, 0.0)
*/