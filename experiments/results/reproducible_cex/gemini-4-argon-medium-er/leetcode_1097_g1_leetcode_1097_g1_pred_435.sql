-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (NULL, 1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(1, 0, None)
*/

-- Prediction Query
WITH CT1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS MIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID), CT2 AS (SELECT A.PLAYER_ID FROM ACTIVITY AS A JOIN CT1 AS C ON A.PLAYER_ID = C.PLAYER_ID AND A.EVENT_DATE = C.MIN_DATE + 1) SELECT C1.MIN_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(COUNT(C2.PLAYER_ID) * 1.0 AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM CT1 AS C1 LEFT JOIN CT2 AS C2 ON C1.PLAYER_ID = C2.PLAYER_ID GROUP BY C1.MIN_DATE;

/*
Prediction Result:
(1, 1, 0.0)
*/