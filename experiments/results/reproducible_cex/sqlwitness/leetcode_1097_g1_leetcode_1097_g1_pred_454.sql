-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (0, '2023-01-02', NULL, 3), (-1, '2023-01-02', 2, 0), (0, '2023-01-01', 0, NULL), (-1, '2023-01-01', 0, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
*/

-- Prediction Query
WITH MIN_DATES AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS MIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID), NEXT_DAYS AS (SELECT A1.PLAYER_ID, A1.EVENT_DATE, CASE WHEN NOT A2.PLAYER_ID IS NULL THEN 1 ELSE 0 END AS LOGGED_IN_NEXT_DAY FROM ACTIVITY AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE = DATE(A2.EVENT_DATE, '-1 DAY') WHERE EXISTS(SELECT NULL FROM MIN_DATES WHERE A1.PLAYER_ID = PLAYER_ID AND A1.EVENT_DATE = MIN_DATE)) SELECT EVENT_DATE AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(LOGGED_IN_NEXT_DAY) AS REAL) / COUNT(PLAYER_ID), 2) AS DAY1_RETENTION FROM NEXT_DAYS GROUP BY EVENT_DATE;

/*
Prediction Result:
('2023-01-01', 2, 1.0)
*/