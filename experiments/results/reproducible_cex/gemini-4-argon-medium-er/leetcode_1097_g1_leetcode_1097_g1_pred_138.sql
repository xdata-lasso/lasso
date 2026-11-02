-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-01', 1, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2020-01-02', 1, 5);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, '2021-01-01', 1, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('2020-01-01', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT EVENT_DATE, PLAYER_ID FROM (SELECT EVENT_DATE, PLAYER_ID, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RN FROM ACTIVITY) AS TEMP WHERE RN = 1), CTE2 AS (SELECT A.EVENT_DATE AS EVENT_DATE1, B.EVENT_DATE AS EVENT_DATE2, A.PLAYER_ID FROM CTE AS A LEFT JOIN ACTIVITY AS B ON A.PLAYER_ID = B.PLAYER_ID AND B.EVENT_DATE - A.EVENT_DATE = 1) SELECT EVENT_DATE1 AS INSTALL_DT, COUNT(PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN NOT EVENT_DATE2 IS NULL THEN 1 ELSE 0 END) AS REAL) / COUNT(PLAYER_ID), 2) AS DAY1_RETENTION FROM CTE2 GROUP BY EVENT_DATE1;

/*
Prediction Result:
('2020-01-01', 1, 1.0)
*/