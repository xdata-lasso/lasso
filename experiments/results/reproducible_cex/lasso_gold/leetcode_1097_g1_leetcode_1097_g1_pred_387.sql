-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1166, '1973-03-12', 1168, 1169);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1166, '1973-03-13', 1158, 1159);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('1973-03-12', 1, 0.0)
*/

-- Prediction Query
WITH INSTALL_DATES AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY PLAYER_ID), PLAYERS_INSTALLED AS (SELECT INSTALL_DATE, COUNT(DISTINCT PLAYER_ID) AS INSTALL_COUNT FROM INSTALL_DATES GROUP BY INSTALL_DATE), PLAYERS_LOGGEDBACK AS (SELECT A.INSTALL_DATE, COUNT(DISTINCT B.PLAYER_ID) AS RETENTION_COUNT FROM INSTALL_DATES AS A JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE = DATE(A.INSTALL_DATE, '1 DAY') GROUP BY A.INSTALL_DATE) SELECT A.INSTALL_DATE AS INSTALL_DT, A.INSTALL_COUNT AS INSTALLS, ROUND(COALESCE(CAST(B.RETENTION_COUNT AS REAL) / A.INSTALL_COUNT, 0), 2) AS DAY1_RETENTION FROM PLAYERS_INSTALLED AS A LEFT JOIN PLAYERS_LOGGEDBACK AS B ON A.INSTALL_DATE = B.INSTALL_DATE;

/*
Prediction Result:
('1973-03-12', 1, 1.0)
*/