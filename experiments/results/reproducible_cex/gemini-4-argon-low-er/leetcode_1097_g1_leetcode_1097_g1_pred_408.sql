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
WITH PLAYER_INSTALL_DATES AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), INSTALL_DATE_COUNTS AS (SELECT INSTALL_DATE, COUNT(DISTINCT (PLAYER_ID)) AS INSTALL_DATE_COUNT FROM PLAYER_INSTALL_DATES GROUP BY 1), DAY_ONE_RETENTION AS (SELECT PLAYER_ID, INSTALL_DATE, CASE WHEN DATE(INSTALL_DATE, '+1 day') IN (SELECT EVENT_DATE FROM ACTIVITY WHERE ACTIVITY.PLAYER_ID = PLAYER_INSTALL_DATES.PLAYER_ID) THEN 1 ELSE 0 END AS DAY_ONE_FLAG FROM PLAYER_INSTALL_DATES), RETENTION_RATIO AS (SELECT I.INSTALL_DATE AS INSTALL_DT, INSTALL_DATE_COUNT AS INSTALLS, ROUND(CAST(SUM(DAY_ONE_FLAG) AS REAL) / INSTALL_DATE_COUNT, 2) AS DAY1_RETENTION FROM INSTALL_DATE_COUNTS AS I JOIN DAY_ONE_RETENTION AS D ON I.INSTALL_DATE = D.INSTALL_DATE GROUP BY 1, 2) SELECT * FROM RETENTION_RATIO;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/