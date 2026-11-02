-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1, NULL, 1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
(None, 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT MIN(EVENT_DATE) AS FIRST, PLAYER_ID FROM ACTIVITY GROUP BY PLAYER_ID) SELECT B.FIRST AS INSTALL_DT, COUNT(FIRST) AS INSTALLS, ROUND(CAST(COUNT(NEXT) AS REAL) / COUNT(FIRST), 2) AS DAY1_RETENTION FROM (SELECT CTE.PLAYER_ID, CTE.FIRST, A.EVENT_DATE AS NEXT FROM CTE LEFT JOIN ACTIVITY AS A ON CTE.PLAYER_ID = A.PLAYER_ID AND CTE.FIRST + 1 = A.EVENT_DATE) AS B GROUP BY 1;

/*
Prediction Result:
(None, 0, None)
*/