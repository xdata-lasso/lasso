-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-01', 10, 5);
INSERT INTO Activity (player_id, event_date, device_id, games_played) VALUES (1, '2020-01-02', 10, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT A1.PLAYER_ID, A1.EVENT_DATE AS FIRST_LOGIN, A2.EVENT_DATE AS SECOND_LOGIN, RANK() OVER (PARTITION BY A1.PLAYER_ID ORDER BY A1.EVENT_DATE) AS RANKING FROM ACTIVITY AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND CAST((JULIANDAY(A2.EVENT_DATE) - JULIANDAY(A1.EVENT_DATE)) AS INTEGER) = 1), CTE_1 AS (SELECT PLAYER_ID, FIRST_LOGIN, SECOND_LOGIN FROM CTE WHERE RANKING = 1) SELECT FIRST_LOGIN AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(COUNT(SECOND_LOGIN) AS REAL) / COUNT(FIRST_LOGIN), 2) AS DAY1_RETENTION FROM CTE_1 GROUP BY FIRST_LOGIN;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/