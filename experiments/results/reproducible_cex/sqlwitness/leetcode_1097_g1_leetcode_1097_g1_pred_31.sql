-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO activity (player_id, event_date, device_id, games_played) VALUES (1, '2023-01-01', 3, 3), (3, '2023-01-02', 1, NULL), (1, '2023-01-02', 2, NULL), (2, '2023-01-02', -1, 2), (-1, '2023-01-01', 1, 3);
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
WITH I AS (SELECT PLAYER_ID, MIN(EVENT_DATE) AS EVENT_DATE FROM ACTIVITY GROUP BY 1), R AS (SELECT EVENT_DATE, COUNT(*) AS RETENTION FROM (SELECT A.* FROM I AS A CROSS JOIN ACTIVITY AS B WHERE A.PLAYER_ID = B.PLAYER_ID AND CAST((JULIANDAY(A.EVENT_DATE) - JULIANDAY(B.EVENT_DATE)) AS INTEGER) = -1) AS C GROUP BY 1) SELECT A.EVENT_DATE AS INSTALL_DT, A.CNT AS INSTALLS, ROUND(CAST(COALESCE(B.RETENTION, 0) AS REAL) / A.CNT, 2) AS DAY1_RETENTION FROM (SELECT EVENT_DATE, COUNT(*) AS CNT FROM I GROUP BY 1) AS A LEFT JOIN R AS B ON A.EVENT_DATE = B.EVENT_DATE;

/*
Prediction Result:
('2023-01-01', 2, 0.5)
('2023-01-02', 2, 0.0)
*/