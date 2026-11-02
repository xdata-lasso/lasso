-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, NULL, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(None, 1, 0.0)
*/

-- Prediction Query
WITH PLAYER_INSTALL_DATES AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), DAY1_LOGIN AS (SELECT A.PLAYER_ID, A.INSTALL_DATE, CASE WHEN NOT B.EVENT_DATE IS NULL THEN 1 ELSE 0 END AS DAY1_LOGIN FROM (SELECT * FROM PLAYER_INSTALL_DATES) AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.INSTALL_DATE + 1 = B.EVENT_DATE) SELECT A.INSTALL_DATE AS INSTALL_DT, B.INSTALLS, ROUND(CAST(A.DAY1_LOGINS AS REAL) / B.INSTALLS, 2) AS DAY1_RETENTION FROM (SELECT INSTALL_DATE, SUM(DAY1_LOGIN) AS DAY1_LOGINS FROM DAY1_LOGIN GROUP BY 1) AS A LEFT JOIN (SELECT INSTALL_DATE, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM PLAYER_INSTALL_DATES GROUP BY 1) AS B ON A.INSTALL_DATE = B.INSTALL_DATE;

/*
Prediction Result:
(None, None, None)
*/