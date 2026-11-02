-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH RANKING AS (SELECT PLAYER_ID, DEVICE_ID, EVENT_DATE, GAMES_PLAYED, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NUMBER FROM ACTIVITY), INSTALL_TABLE AS (SELECT EVENT_DATE, COUNT(*) AS INST FROM RANKING WHERE NUMBER = 1 GROUP BY EVENT_DATE), TAB_DAY1 AS (SELECT PLAYER_ID, EVENT_DATE, INSTALLS, NEXTS, NEXTS = EVENT_DATE AS "1_DAY" FROM (SELECT PLAYER_ID, EVENT_DATE, LAG(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS INSTALLS, DATE(LAG(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE), '1 DAY') AS NEXTS, NUMBER FROM RANKING) AS TAB1 WHERE NUMBER = 2), TAB_DAY1_GROUP AS (SELECT INSTALLS, COUNT(*) AS DAY1 FROM TAB_DAY1 WHERE "1_DAY" = 1 GROUP BY INSTALLS) SELECT EVENT_DATE AS INSTALL_DT, INST AS INSTALLS, ROUND(CAST((COALESCE(DAY1, 0) * 1.) AS REAL) / (INST), 2) AS DAY1_RETENTION FROM INSTALL_TABLE LEFT JOIN TAB_DAY1_GROUP ON EVENT_DATE = INSTALLS;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/