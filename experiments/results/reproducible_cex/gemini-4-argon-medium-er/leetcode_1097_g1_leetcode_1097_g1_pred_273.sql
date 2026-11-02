-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 10, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH TEMP AS (SELECT PLAYER_ID, EVENT_DATE FROM (SELECT *, RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RANKING FROM ACTIVITY) AS A WHERE A.RANKING = 1), TEMP2 AS (SELECT EVENT_DATE, COUNT(PLAYER_ID) AS INSTALLS FROM TEMP GROUP BY EVENT_DATE), TEMP3 AS (SELECT T.EVENT_DATE, COUNT(A.PLAYER_ID) AS CT FROM TEMP AS T LEFT JOIN ACTIVITY AS A ON T.PLAYER_ID = A.PLAYER_ID AND T.EVENT_DATE = DATE(A.EVENT_DATE, '-1 day') GROUP BY T.EVENT_DATE) SELECT TEMP2.EVENT_DATE AS INSTALL_DT, TEMP2.INSTALLS, ROUND((CAST(TEMP3.CT AS REAL) / TEMP2.INSTALLS), 2) AS DAY1_RETENTION FROM TEMP2 JOIN TEMP3 ON TEMP2.EVENT_DATE = TEMP3.EVENT_DATE;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/