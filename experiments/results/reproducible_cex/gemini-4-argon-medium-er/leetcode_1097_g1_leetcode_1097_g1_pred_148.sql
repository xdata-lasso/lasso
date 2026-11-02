-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-02', 1, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY 1), DAY1 AS (SELECT F.PLAYER_ID, F.INSTALL_DATE FROM FIRST_LOGIN AS F JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(F.INSTALL_DATE)) AS INTEGER) = 1) SELECT F.INSTALL_DATE AS INSTALL_DT, COUNT(F.PLAYER_ID) AS INSTALLS, ROUND(CAST(COUNT(DAY1.PLAYER_ID) AS REAL) / COUNT(F.PLAYER_ID), 2) AS DAY1_RETENTION FROM FIRST_LOGIN AS F LEFT JOIN DAY1 ON DAY1.PLAYER_ID = F.PLAYER_ID AND F.INSTALL_DATE = DAY1.INSTALL_DATE GROUP BY 1;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/