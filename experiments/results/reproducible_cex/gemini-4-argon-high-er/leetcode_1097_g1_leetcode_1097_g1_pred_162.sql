-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH INSTALLDATEPLAYER AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY PLAYER_ID) SELECT INSTALLDATEPLAYER.INSTALL_DATE AS INSTALL_DT, COUNT(1) AS INSTALLS, ROUND(CAST(COALESCE(TEMP.RETENTION, 0) AS REAL) / COUNT(1), 2) AS DAY1_RETENTION FROM INSTALLDATEPLAYER LEFT OUTER JOIN (SELECT I2.INSTALL_DATE, COUNT(I2.PLAYER_ID) AS RETENTION FROM INSTALLDATEPLAYER AS I2 INNER JOIN ACTIVITY ON ACTIVITY.PLAYER_ID = I2.PLAYER_ID AND DATE(I2.INSTALL_DATE, '1 DAY') = ACTIVITY.EVENT_DATE GROUP BY I2.INSTALL_DATE) AS TEMP ON INSTALLDATEPLAYER.INSTALL_DATE = TEMP.INSTALL_DATE GROUP BY INSTALLDATEPLAYER.INSTALL_DATE;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/