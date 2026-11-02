-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (3, '2023-01-02', NULL, 2), (-1, '2023-01-02', 0, 0), (0, '2023-01-01', 2, 2), (1, '2023-01-02', 1, NULL), (1, '2023-01-01', 3, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
('2023-01-02', 2, 0.0)
*/

-- Prediction Query
WITH INSTALL AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), RETAINTED_USERS AS (SELECT B.INSTALL_DATE, COUNT(DISTINCT A.PLAYER_ID) AS CNT_RETAINERS FROM ACTIVITY AS A JOIN INSTALL AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE = DATE(B.INSTALL_DATE, '+1 day') GROUP BY 1) SELECT A.INSTALL_DATE AS INSTALL_DT, COUNT(DISTINCT A.PLAYER_ID) AS INSTALLS, ROUND(CAST(COALESCE(CNT_RETAINERS, 0) * 1.0 AS REAL) / COUNT(DISTINCT A.PLAYER_ID), 2) AS DAY1_RETENTION FROM INSTALL AS A LEFT JOIN RETAINTED_USERS AS B ON A.INSTALL_DATE = B.INSTALL_DATE GROUP BY 1, CNT_RETAINERS;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 2, 0.0)
*/