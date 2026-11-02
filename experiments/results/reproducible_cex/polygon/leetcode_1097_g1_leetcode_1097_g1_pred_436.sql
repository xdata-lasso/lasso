-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (14, '0998-01-11', NULL, 0);
INSERT INTO "Activity" ("player_id", "event_date", "device_id", "games_played") VALUES (14, '0998-01-12', 20, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('0998-01-11', 1, 0.0)
*/

-- Prediction Query
SELECT EVENT_DATE AS INSTALL_DT, COUNT(DAY1PLAYER) AS INSTALLS, ROUND(CAST(COUNT(DAY2PLAYER) AS REAL) / COUNT(DAY1PLAYER), 2.0) AS DAY1_RETENTION FROM (SELECT A1.EVENT_DATE, A1.PLAYER_ID AS DAY1PLAYER, ROW_NUMBER() OVER (PARTITION BY A1.PLAYER_ID ORDER BY A1.EVENT_DATE) AS DAYRANK, A2.PLAYER_ID AS DAY2PLAYER FROM ACTIVITY AS A1 LEFT JOIN ACTIVITY AS A2 ON A1.PLAYER_ID = A2.PLAYER_ID AND A1.EVENT_DATE + 1 = A2.EVENT_DATE) AS TEMP WHERE DAYRANK = 1 GROUP BY EVENT_DATE;

/*
Prediction Result:
('0998-01-11', 1, 0.0)
*/