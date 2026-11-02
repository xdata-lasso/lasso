-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH RK AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS F_DATE FROM ACTIVITY GROUP BY PLAYER_ID), MPP AS (SELECT PLAYER_ID, F_DATE, DATE(F_DATE, '1 DAY') AS S_DATE FROM RK), FP AS (SELECT A.PLAYER_ID, A.F_DATE, A.S_DATE, CASE WHEN B.EVENT_DATE IS NULL THEN 0 ELSE 1 END AS ACT FROM MPP AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.S_DATE = B.EVENT_DATE) SELECT F_DATE AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(ACT) AS REAL) / COUNT(ACT), 2) AS DAY1_RETENTION FROM FP GROUP BY INSTALL_DT;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/