-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-03-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-03-02', 1, 6);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (2, '2020-06-25', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2020-03-01', 2, 0);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (3, '2020-07-03', 2, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-03-01', 2, 0.0)
('2020-06-25', 1, 0.0)
*/

-- Prediction Query
WITH T1 AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY 1), T2 AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM T1 GROUP BY 1), T3 AS (SELECT INSTALL_DT, COUNT(EVENT_DATE) AS RETURN_NUM FROM (SELECT T1.PLAYER_ID, INSTALL_DT, EVENT_DATE FROM T1 JOIN ACTIVITY AS A ON T1.PLAYER_ID = A.PLAYER_ID WHERE CAST((JULIANDAY(EVENT_DATE) - JULIANDAY(INSTALL_DT)) AS INTEGER) = 1) AS TEMP GROUP BY 1) SELECT T2.INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(RETURN_NUM, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM T2 LEFT JOIN T3 USING (INSTALL_DT);

/*
Prediction Result:
('2020-03-01', 2, 0.5)
('2020-06-25', 1, 0.0)
*/