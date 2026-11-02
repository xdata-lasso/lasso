-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (0, '2023-01-02', 3, 3), (1, '2023-01-02', 2, 2), (0, '2023-01-01', 3, 2), (1, '2023-01-01', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
*/

-- Prediction Query
SELECT INSTALL_DT, COUNT(INSTALL_DT) AS INSTALLS, ROUND(CAST(COUNT(NEXT_DT) AS REAL) / COUNT(INSTALL_DT), 2) AS DAY1_RETENTION FROM (SELECT T1.PLAYER_ID, T1.EVENT_DATE AS INSTALL_DT, T2.EVENT_DATE AS NEXT_DT FROM (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS T1 LEFT JOIN ACTIVITY AS T2 ON T2.PLAYER_ID = T1.PLAYER_ID AND CAST((JULIANDAY(T2.EVENT_DATE) - JULIANDAY(T1.EVENT_DATE)) AS INTEGER) = 1) AS T GROUP BY INSTALL_DT ORDER BY INSTALL_DT ASC, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2023-01-01', 2, 1.0)
*/