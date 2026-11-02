-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (2, '2023-01-02', 1, 2), (0, '2023-01-02', NULL, NULL), (0, '2023-01-01', 3, NULL), (-1, '2023-01-02', -1, 1), (3, '2023-01-01', 1, 2), (-1, '2023-01-01', 0, 1), (1, '2023-01-01', 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2023-01-01', 4, 0.0)
('2023-01-02', 1, 0.0)
*/

-- Prediction Query
SELECT C.EVENT_DATE AS INSTALL_DT, SUM(FIRST_DAY) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN DAYS = 1 AND FIRST_DAY = 1 THEN 1 ELSE 0 END) AS REAL) / SUM(FIRST_DAY), 2) AS DAY1_RETENTION FROM (SELECT A.PLAYER_ID, CAST((JULIANDAY(A.NEXT_DATE) - JULIANDAY(A.EVENT_DATE)) AS INTEGER) AS DAYS, A.EVENT_DATE, CASE WHEN A.EVENT_DATE = B.MIN_DATE THEN 1 ELSE 0 END AS FIRST_DAY FROM (SELECT PLAYER_ID, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_DATE, EVENT_DATE FROM ACTIVITY) AS A INNER JOIN (SELECT PLAYER_ID, MIN(EVENT_DATE) AS MIN_DATE FROM ACTIVITY GROUP BY PLAYER_ID) AS B ON A.PLAYER_ID = B.PLAYER_ID) AS C WHERE C.FIRST_DAY = 1 GROUP BY C.EVENT_DATE ORDER BY C.EVENT_DATE, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('2023-01-01', 4, 0.5)
('2023-01-02', 1, 0.0)
*/