-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (0, '2023-01-02', 0, NULL), (1, '2023-01-01', NULL, 2), (1, '2023-01-02', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 1, 0.0)
('2023-01-02', 1, 0.0)
*/

-- Prediction Query
WITH TBDATE AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY PLAYER_ID), TBTCNT AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS INSTALLS FROM TBDATE GROUP BY EVENT_DATE), TBCNT AS (SELECT TBDATE.EVENT_DATE AS INSTALL_DT, TBTCNT.INSTALLS, ROUND(CAST(COUNT(A2.PLAYER_ID) AS REAL) / TBTCNT.INSTALLS, 2) AS DAY1_RETENTION FROM TBDATE LEFT JOIN TBTCNT ON TBTCNT.EVENT_DATE = TBDATE.EVENT_DATE LEFT JOIN ACTIVITY AS A2 ON CAST((JULIANDAY(A2.EVENT_DATE) - JULIANDAY(TBDATE.EVENT_DATE)) AS INTEGER) = 1 AND A2.PLAYER_ID = TBDATE.PLAYER_ID GROUP BY TBDATE.EVENT_DATE) SELECT * FROM TBCNT;

/*
Prediction Result:
('2023-01-01', 1, 1.0)
('2023-01-02', 1, 0.0)
*/