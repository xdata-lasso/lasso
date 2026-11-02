-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH IN_DT AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN FROM ACTIVITY AS A GROUP BY 1), RETENT AS (SELECT DISTINCT I.PLAYER_ID, FIRST_LOGIN FROM IN_DT AS I INNER JOIN ACTIVITY AS A ON A.PLAYER_ID = I.PLAYER_ID AND DATE(I.FIRST_LOGIN, '1 DAY') = A.EVENT_DATE) SELECT I.FIRST_LOGIN AS INSTALL_DT, COUNT(DISTINCT I.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(DISTINCT R.PLAYER_ID) AS REAL) / COUNT(DISTINCT I.PLAYER_ID), 2) AS DAY1_RETENTION FROM IN_DT AS I LEFT JOIN RETENT AS R ON R.PLAYER_ID = I.PLAYER_ID GROUP BY 1 ORDER BY 1 ASC, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/