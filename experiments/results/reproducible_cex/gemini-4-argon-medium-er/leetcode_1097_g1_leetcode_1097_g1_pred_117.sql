-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-02', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH DATE_CTE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), RETENTION_CTE AS (SELECT A.PLAYER_ID FROM ACTIVITY AS A JOIN DATE_CTE AS D ON A.PLAYER_ID = D.PLAYER_ID AND A.EVENT_DATE = DATE(D.INSTALL_DT, '1 DAY')) SELECT D.INSTALL_DT, COUNT(D.PLAYER_ID) AS INSTALLS, ROUND(CAST((1.0 * COUNT(R.PLAYER_ID)) AS REAL) / COUNT(D.PLAYER_ID), 2) AS DAY1_RETENTION FROM DATE_CTE AS D LEFT JOIN RETENTION_CTE AS R ON D.PLAYER_ID = R.PLAYER_ID GROUP BY D.INSTALL_DT ORDER BY D.INSTALL_DT, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/