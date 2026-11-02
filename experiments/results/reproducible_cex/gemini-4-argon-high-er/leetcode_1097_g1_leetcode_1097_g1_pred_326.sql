-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (NULL, '2020-01-01', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, 2020, 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2021-01-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(2020, 1, 0.0)
('2020-01-01', 0, None)
*/

-- Prediction Query
WITH INSTALL AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INS_DT FROM ACTIVITY GROUP BY PLAYER_ID) SELECT INS_DT AS INSTALL_DT, COUNT(1) AS INSTALLS, ROUND(CAST(COUNT(D1LOGDT) AS REAL) / COUNT(1), 2) AS DAY1_RETENTION FROM (SELECT I.PLAYER_ID, INS_DT, A.EVENT_DATE AS D1LOGDT FROM INSTALL AS I LEFT JOIN ACTIVITY AS A ON I.INS_DT = A.EVENT_DATE - 1 AND I.PLAYER_ID = A.PLAYER_ID) AS T GROUP BY 1;

/*
Prediction Result:
(2020, 1, 1.0)
('2020-01-01', 1, 0.0)
*/