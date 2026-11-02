-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200101, 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 20200102, 10, 3);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200101, 20, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, 20200102, 20, 4);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, 20200101, 30, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200110, 40, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (4, 20200111, 40, 2);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (5, 20200110, 50, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (6, 20200110, 60, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(20200101, 3, 0.67)
(20200110, 3, 0.33)
*/

-- Prediction Query
WITH CTE AS (SELECT *, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS LOGIN_DATE, LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS NEXT_LOGIN, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RK FROM ACTIVITY), CTE2 AS (SELECT LOGIN_DATE, COUNT(PLAYER_ID) AS NUM_LOGINS, SUM(CAST((JULIANDAY(NEXT_LOGIN) - JULIANDAY(LOGIN_DATE)) AS INTEGER) = 1) AS REPEAT_LOGINS FROM CTE WHERE RK = 1 GROUP BY LOGIN_DATE) SELECT LOGIN_DATE AS INSTALL_DT, NUM_LOGINS AS INSTALLS, COALESCE(ROUND(CAST(REPEAT_LOGINS AS REAL) / NUM_LOGINS, 2), 0) AS DAY1_RETENTION FROM CTE2 GROUP BY LOGIN_DATE, INSTALLS, DAY1_RETENTION;

/*
Prediction Result:
(20200101, 3, 0)
(20200110, 3, 0)
*/