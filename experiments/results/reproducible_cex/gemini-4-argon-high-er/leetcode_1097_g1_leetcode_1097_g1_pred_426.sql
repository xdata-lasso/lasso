-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 1, 1);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH INSTALL_DATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DT FROM ACTIVITY GROUP BY PLAYER_ID), NEXTDAY AS (SELECT INSTALL_DT, DATE(INSTALL_DT, '1 DAY') AS NEXTDAY FROM INSTALL_DATE GROUP BY INSTALL_DT), PLAYERS_NEXTDAY AS (SELECT X.PLAYER_ID, Y.NEXTDAY FROM INSTALL_DATE AS X JOIN NEXTDAY AS Y ON X.INSTALL_DT = Y.INSTALL_DT), PLAYERS_LOGGED_BACK AS (SELECT A.PLAYER_ID FROM PLAYERS_NEXTDAY AS Z JOIN ACTIVITY AS A ON Z.PLAYER_ID = A.PLAYER_ID AND Z.NEXTDAY = A.EVENT_DATE) SELECT D.INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(IIF(P.PLAYER_ID IS NULL, 0, 1)) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM INSTALL_DATE AS D LEFT JOIN PLAYERS_LOGGED_BACK AS P ON D.PLAYER_ID = P.PLAYER_ID GROUP BY D.INSTALL_DT;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/