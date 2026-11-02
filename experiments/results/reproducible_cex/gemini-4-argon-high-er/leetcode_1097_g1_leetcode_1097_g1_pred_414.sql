-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2017-03-01', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 1, 0.0)
*/

-- Prediction Query
WITH HEL AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY PLAYER_ID) SELECT C.INSTALL_DATE AS INSTALL_DT, INSTALLS, ROUND(CAST(COALESCE(REN, 0) AS REAL) / INSTALLS, 2) AS DAY1_RETENTION FROM (SELECT INSTALL_DATE, COUNT(PLAYER_ID) AS INSTALLS FROM HEL GROUP BY INSTALL_DATE) AS C LEFT JOIN (SELECT A.INSTALL_DATE, COUNT(B.EVENT_DATE) AS REN FROM HEL AS A JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND A.INSTALL_DATE - B.EVENT_DATE = -1 GROUP BY A.INSTALL_DATE) AS D ON C.INSTALL_DATE = D.INSTALL_DATE;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/