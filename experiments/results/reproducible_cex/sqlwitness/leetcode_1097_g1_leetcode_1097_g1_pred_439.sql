-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 0, 2), (0, '2023-01-02', 0, NULL), (-1, '2023-01-02', NULL, 1), (0, '2023-01-01', 1, 0), (-1, '2023-01-01', 2, 3);
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
WITH A AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), B AS (SELECT INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS FROM A GROUP BY INSTALL_DT), C AS (SELECT INSTALL_DT, COUNT(A0.PLAYER_ID) AS RET FROM A JOIN ACTIVITY AS A0 ON A0.PLAYER_ID = A.PLAYER_ID AND A0.EVENT_DATE = DATE(A.INSTALL_DT, '+1 day') GROUP BY INSTALL_DT) SELECT B.INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(RET, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM B LEFT JOIN C ON B.INSTALL_DT = C.INSTALL_DT ORDER BY B.INSTALL_DT, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2023-01-01', 2, 1.0)
('2023-01-02', 1, 0.0)
*/