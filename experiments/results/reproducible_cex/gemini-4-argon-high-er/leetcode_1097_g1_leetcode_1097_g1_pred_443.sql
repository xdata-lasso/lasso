-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2021-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH DT AS (SELECT DISTINCT PLAYER_ID, EVENT_DATE, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RANK1 FROM ACTIVITY), RETEN AS (SELECT DISTINCT A.PLAYER_ID, A.EVENT_DATE, B.EVENT_DATE AS ED1, CASE WHEN ROUND(B.EVENT_DATE - A.EVENT_DATE) = 1 THEN 1 ELSE 0 END AS PLAYER1 FROM DT AS A LEFT JOIN DT AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.RANK1 = 1 AND B.RANK1 = 2 WHERE A.RANK1 = 1) SELECT EVENT_DATE AS INSTALL_DT, COUNT(DISTINCT (PLAYER_ID)) AS INSTALLS, ROUND(CAST(SUM(PLAYER1) AS REAL) / COUNT(DISTINCT (PLAYER_ID)), 2) AS DAY1_RETENTION FROM RETEN GROUP BY 1;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/