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
WITH WA AS (SELECT X.PLAYER_ID, MIN(X.EVENT_DATE) AS INSTALL_DT FROM ACTIVITY AS X GROUP BY 1), WB AS (SELECT X.*, Y.INSTALL_DT, CASE WHEN CAST((JULIANDAY(X.EVENT_DATE) - JULIANDAY(Y.INSTALL_DT)) AS INTEGER) = 1 THEN TRUE ELSE FALSE END AS RETENTION_FLG FROM ACTIVITY AS X LEFT OUTER JOIN WA AS Y ON X.PLAYER_ID = Y.PLAYER_ID) SELECT X.INSTALL_DT, COUNT(DISTINCT X.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(DISTINCT CASE WHEN X.RETENTION_FLG = TRUE THEN X.PLAYER_ID END) AS REAL) / COUNT(DISTINCT X.PLAYER_ID), 2) AS DAY1_RETENTION FROM WB AS X GROUP BY 1 ORDER BY 1, X.INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/