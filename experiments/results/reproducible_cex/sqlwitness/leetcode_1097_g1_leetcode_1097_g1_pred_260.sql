-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-02', 1, 1), (3, '2023-01-01', 0, NULL), (1, '2023-01-01', 0, 1), (2, '2023-01-02', NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
('2023-01-02', 1, 0.0)
*/

-- Prediction Query
WITH INSTALL_DATE AS (SELECT PLAYER_ID, EVENT_DATE FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS ROW_ID FROM ACTIVITY) AS TEMP WHERE ROW_ID = 1) SELECT A.EVENT_DATE AS INSTALL_DT, COUNT(A.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(B.PLAYER_ID) * 1.0 AS REAL) / COUNT(A.PLAYER_ID), 2) AS DAY1_RETENTION FROM INSTALL_DATE AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND DATE(B.EVENT_DATE, '-1 DAY') = A.EVENT_DATE GROUP BY A.EVENT_DATE;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 1, 0.0)
*/