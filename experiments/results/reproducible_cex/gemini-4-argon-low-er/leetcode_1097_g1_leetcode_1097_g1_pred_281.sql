-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-01', 2, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 1, 0.0)
*/

-- Prediction Query
WITH PLAYERINFO AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), PLAYERRET AS (SELECT INSTALL_DATE, PI.PLAYER_ID FROM PLAYERINFO AS PI JOIN ACTIVITY AS ACT ON PI.PLAYER_ID = ACT.PLAYER_ID AND CAST((JULIANDAY(ACT.EVENT_DATE) - JULIANDAY(INSTALL_DATE)) AS INTEGER) = 1) SELECT PI.INSTALL_DATE AS INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(RETENTION, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM (SELECT INSTALL_DATE, COUNT(PLAYER_ID) AS INSTALLS FROM PLAYERINFO GROUP BY 1) AS PI LEFT JOIN (SELECT INSTALL_DATE, COUNT(DISTINCT PLAYER_ID) AS RETENTION FROM PLAYERRET GROUP BY 1) AS PR USING (INSTALL_DATE) GROUP BY PI.INSTALL_DATE ORDER BY 1, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/