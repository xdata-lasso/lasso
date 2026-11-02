-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (0, '2023-01-02', 1, 2), (3, '2023-01-02', 2, 0), (0, '2023-01-01', 2, 2), (-1, '2023-01-01', 0, NULL), (1, '2023-01-02', -1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 2, 0.0)
('2023-01-02', 2, 0.0)
*/

-- Prediction Query
WITH FIRST_LOGIN AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS FIRST_LOGIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID) SELECT FIRST_LOGIN_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(AVG(CASE WHEN B.PLAYER_ID IS NULL THEN 0 ELSE 1 END), 2) AS DAY1_RETENTION FROM FIRST_LOGIN AS A LEFT JOIN ACTIVITY AS B ON B.EVENT_DATE = DATE(A.FIRST_LOGIN_DATE, '+1 day') AND A.PLAYER_ID = B.PLAYER_ID GROUP BY FIRST_LOGIN_DATE;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 2, 0.0)
*/