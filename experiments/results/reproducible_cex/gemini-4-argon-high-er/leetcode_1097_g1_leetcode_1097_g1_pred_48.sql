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
WITH FIRST_LOGIN AS (SELECT EVENT_DATE, PLAYER_ID FROM (SELECT EVENT_DATE, PLAYER_ID, DENSE_RANK() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) AS A WHERE A.RNK = 1), ONE_PLUS_DAYS AS (SELECT F.PLAYER_ID, F.EVENT_DATE AS FIRST_DATE, A.EVENT_DATE AS SECOND_DATE FROM FIRST_LOGIN AS F LEFT JOIN ACTIVITY AS A ON F.PLAYER_ID = A.PLAYER_ID AND F.EVENT_DATE = DATE(A.EVENT_DATE, '-1 DAY')), CASES AS (SELECT FIRST_DATE, SECOND_DATE, CASE WHEN NOT SECOND_DATE IS NULL THEN 1 ELSE 0 END AS CNT1 FROM ONE_PLUS_DAYS) SELECT FIRST_DATE AS INSTALL_DT, COUNT(*) AS INSTALLS, ROUND(CAST(SUM(CNT1) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM CASES GROUP BY FIRST_DATE;

/*
Prediction Result:
('2016-03-01', 1, 1.0)
*/