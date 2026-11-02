-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', -1, 3), (2, '2023-01-01', 2, 3), (-1, '2023-01-02', 0, 0), (0, '2023-01-01', NULL, 3), (-1, '2023-01-01', 0, 0), (1, '2023-01-01', NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 4, 0.0)
*/

-- Prediction Query
WITH INSTALLS AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS INSTALL_DATE FROM ACTIVITY GROUP BY PLAYER_ID), DAILY_INSTALLS AS (SELECT INSTALL_DATE, COUNT(PLAYER_ID) AS D_INSTALLS FROM INSTALLS GROUP BY INSTALL_DATE), VALID_PLAYERS AS (SELECT ID.INSTALL_DATE, COUNT(DISTINCT ID.PLAYER_ID) AS GOOD_PLAYERS FROM ACTIVITY AS A LEFT JOIN INSTALLS AS ID ON A.PLAYER_ID = ID.PLAYER_ID AND A.EVENT_DATE = DATE(ID.INSTALL_DATE, '1 DAY') GROUP BY 1) SELECT D.INSTALL_DATE AS INSTALL_DT, D.D_INSTALLS AS INSTALLS, ROUND(COALESCE(CAST(GOOD_PLAYERS AS REAL) / D.D_INSTALLS, 0), 2) AS DAY1_RETENTION FROM DAILY_INSTALLS AS D LEFT JOIN ACTIVITY AS A ON A.EVENT_DATE = D.INSTALL_DATE LEFT JOIN VALID_PLAYERS AS VP ON D.INSTALL_DATE = VP.INSTALL_DATE GROUP BY D.INSTALL_DATE, D.D_INSTALLS;

/*
Prediction Result:
('2023-01-01', 4, 0.5)
*/