-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (75, '0998-09-25', -719, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (12, '0998-01-12', -719, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('0998-01-12', 1, 0.0)
('0998-09-25', 1, 0.0)
*/

-- Prediction Query
SELECT FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT T.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(DISTINCT A.PLAYER_ID) AS REAL) / COUNT(DISTINCT T.PLAYER_ID), 2) AS DAY1_RETENTION FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS FIRST_LOGIN FROM ACTIVITY) AS T LEFT JOIN ACTIVITY AS A ON T.PLAYER_ID = A.PLAYER_ID AND FIRST_LOGIN = A.EVENT_DATE - 1 GROUP BY FIRST_LOGIN;

/*
Prediction Result:
('0998-01-12', 1, 0.0)
('0998-09-25', 1, 0.0)
*/