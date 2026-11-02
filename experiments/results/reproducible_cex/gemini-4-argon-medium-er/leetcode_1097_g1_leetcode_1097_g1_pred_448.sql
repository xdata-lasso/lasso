-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-01', 2, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2016-03-02', 2, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2016-03-01', 1, 0.0)
*/

-- Prediction Query
WITH INSTALL_DATE_TABLE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY PLAYER_ID), INSTALL_DATE_NUM_TABLE AS (SELECT INSTALL_DATE, COUNT(PLAYER_ID) AS PLAYER_NUM FROM INSTALL_DATE_TABLE GROUP BY INSTALL_DATE), NEW_ACTIVITY AS (SELECT A.PLAYER_ID, EVENT_DATE, IDT.INSTALL_DATE, PLAYER_NUM, CASE WHEN EVENT_DATE = DATE(IDT.INSTALL_DATE, '1 DAY') THEN 1 ELSE 0 END AS RETAINED FROM ACTIVITY AS A LEFT JOIN INSTALL_DATE_TABLE AS IDT ON A.PLAYER_ID = IDT.PLAYER_ID LEFT JOIN INSTALL_DATE_NUM_TABLE AS IDNT ON IDT.INSTALL_DATE = IDNT.INSTALL_DATE) SELECT INSTALL_DATE AS INSTALL_DT, MAX(PLAYER_NUM) AS INSTALLS, ROUND(CAST(SUM(RETAINED) AS REAL) / MAX(PLAYER_NUM), 2) AS DAY1_RETENTION FROM NEW_ACTIVITY GROUP BY INSTALL_DATE;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/