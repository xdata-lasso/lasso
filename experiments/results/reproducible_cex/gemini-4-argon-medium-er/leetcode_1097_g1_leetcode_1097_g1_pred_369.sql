-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 10, 6);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH TEMP AS (SELECT PLAYER_ID, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS INSTALL_DT, CAST((JULIANDAY(LEAD(EVENT_DATE, 1) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE ASC)) - JULIANDAY(MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID))) AS INTEGER) AS N_DAYS FROM ACTIVITY) SELECT A.INSTALL_DT, A.INSTALLS, ROUND(COALESCE((CAST(B.DAY1_USERS_CNT AS REAL) / A.INSTALLS), 0), 2) AS DAY1_RETENTION FROM (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS FROM TEMP GROUP BY INSTALL_DT) AS A LEFT JOIN (SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS DAY1_USERS_CNT FROM TEMP WHERE N_DAYS = 1 GROUP BY INSTALL_DT) AS B ON A.INSTALL_DT = B.INSTALL_DT;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/