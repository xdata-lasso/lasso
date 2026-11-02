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
WITH CTE AS (SELECT *, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS LOGIN_RANK FROM ACTIVITY), CTE2 AS (SELECT PLAYER_ID, MAX(CASE WHEN LOGIN_RANK = 1 THEN EVENT_DATE ELSE NULL END) AS INSTALL_DT, MAX(CASE WHEN LOGIN_RANK = 2 THEN EVENT_DATE ELSE NULL END) AS SECOND_LOGIN_DT FROM CTE WHERE LOGIN_RANK <= 2 GROUP BY 1) SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(AVG(CASE WHEN CAST((JULIANDAY(SECOND_LOGIN_DT) - JULIANDAY(INSTALL_DT)) AS INTEGER) = 1 THEN 1 ELSE 0 END), 2) AS DAY1_RETENTION FROM CTE2 GROUP BY 1 ORDER BY 1, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-03-01', 2, 0.5)
('2020-06-25', 1, 0.0)
*/