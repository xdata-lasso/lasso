-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (17, '0998-09-25', -463, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (16, '0998-09-23', -463, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('0998-09-23', 1, 0.0)
('0998-09-25', 1, 0.0)
*/

-- Prediction Query
WITH TB1 AS (SELECT PLAYER_ID, EVENT_DATE, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC) AS RK FROM ACTIVITY), TB2 AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS INSTALL FROM TB1 WHERE RK = 1 GROUP BY EVENT_DATE), TB3 AS (SELECT A.EVENT_DATE, COUNT(A.PLAYER_ID) AS RET FROM TB1 AS A CROSS JOIN TB1 AS B WHERE A.PLAYER_ID = B.PLAYER_ID AND A.EVENT_DATE + 1 = B.EVENT_DATE AND A.RK = 1 GROUP BY A.EVENT_DATE) SELECT TB2.EVENT_DATE AS INSTALL_DT, INSTALL AS INSTALLS, ROUND(COALESCE(CAST(RET AS REAL) / INSTALL, 0), 2) AS DAY1_RETENTION FROM TB2 LEFT JOIN TB3 ON TB2.EVENT_DATE = TB3.EVENT_DATE;

/*
Prediction Result:
('0998-09-23', 1, 0.0)
('0998-09-25', 1, 0.0)
*/