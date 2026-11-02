-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 100, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 101, 10, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 102, 10, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 100, 20, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 102, 20, 4);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 100, 30, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 101, 40, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 102, 50, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 103, 50, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(100, 3, 0.33)
(101, 1, 0.0)
(102, 1, 1.0)
*/

-- Prediction Query
WITH MIN_DATES AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS MIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID), NEXT_DAYS AS (SELECT A1.PLAYER_ID, A1.EVENT_DATE, CASE WHEN NOT A2.PLAYER_ID IS NULL THEN 1 ELSE 0 END AS LOGGED_IN_NEXT_DAY FROM ACTIVITY AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = DATE(A2.EVENT_DATE, '-1 DAY') WHERE EXISTS(SELECT NULL FROM MIN_DATES WHERE A1.PLAYER_ID = PLAYER_ID AND A1.EVENT_DATE = MIN_DATE)) SELECT EVENT_DATE AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(LOGGED_IN_NEXT_DAY) AS REAL) / COUNT(PLAYER_ID), 2) AS DAY1_RETENTION FROM NEXT_DAYS GROUP BY EVENT_DATE;

/*
Prediction Result:
(100, 3, 0.0)
(101, 1, 0.0)
(102, 1, 0.0)
*/