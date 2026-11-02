-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', NULL, 0), (3, '2023-01-01', 2, 2), (2, '2023-01-02', 2, 0), (3, '2023-01-02', 2, NULL), (0, '2023-01-02', NULL, 1);
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
SELECT T.INSTALL_DT, COUNT(T.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(T.NEXT_DAY) AS REAL) / COUNT(T.PLAYER_ID), 2) AS DAY1_RETENTION FROM (SELECT A1.PLAYER_ID, A1.INSTALL_DT, A2.EVENT_DATE AS NEXT_DAY FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID) AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND CAST((JULIANDAY(A2.EVENT_DATE) - JULIANDAY(A1.INSTALL_DT)) AS INTEGER) = 1) AS T GROUP BY T.INSTALL_DT;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 2, 0.0)
*/