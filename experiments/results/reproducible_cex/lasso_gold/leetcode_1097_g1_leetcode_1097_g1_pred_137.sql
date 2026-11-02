-- Schema DDL
CREATE TABLE "Activity" ("player_id" INTEGER, "event_date" DATE, "device_id" INTEGER, "games_played" INTEGER, PRIMARY KEY ("player_id", "event_date"), CHECK ("games_played" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1067, '1972-12-03', 1069, 1070);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1067, '1972-12-06', 1072, 1073);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1076, '1972-12-10', 1072, 1073);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '1972-12-13', 1079, 1080);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (NULL, '1972-12-16', 1082, 1083);
INSERT INTO "activity" ("player_id", "event_date", "device_id", "games_played") VALUES (1086, '1972-12-20', 1082, 1083);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT install_dt, COUNT(player_id) AS installs, ROUND(CAST(COUNT(next_day) AS REAL) / COUNT(player_id), 2) AS Day1_retention FROM (SELECT a1.player_id, a1.install_dt, a2.event_date AS next_day FROM (SELECT player_id, MIN(event_date) AS install_dt FROM Activity GROUP BY player_id) AS a1 LEFT JOIN Activity AS a2 ON a1.player_id = a2.player_id AND a2.event_date = a1.install_dt + 1) AS t GROUP BY install_dt;

/*
Gold Result:
('1972-12-03', 1, 0.0)
('1972-12-10', 1, 0.0)
('1972-12-13', 0, None)
('1972-12-20', 1, 0.0)
*/

-- Prediction Query
WITH CTE AS (SELECT *, MIN(EVENT_DATE) OVER (PARTITION BY PLAYER_ID) AS INSTALL_DT, LEAD(EVENT_DATE) OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS NEXT_DATE, ROW_NUMBER() OVER (PARTITION BY PLAYER_ID ORDER BY EVENT_DATE) AS RNK FROM ACTIVITY) SELECT INSTALL_DT, COUNT(DISTINCT PLAYER_ID) AS INSTALLS, ROUND(CAST(SUM(CASE WHEN NEXT_DATE = EVENT_DATE + 1 THEN 1 ELSE 0 END) AS REAL) / COUNT(*), 2) AS DAY1_RETENTION FROM CTE WHERE RNK = 1 GROUP BY 1 ORDER BY 1, INSTALL_DT NULLS LAST, INSTALLS NULLS LAST, DAY1_RETENTION NULLS LAST;

/*
Prediction Result:
('1972-12-03', 1, 0.0)
('1972-12-10', 1, 0.0)
('1972-12-13', 0, 0.0)
('1972-12-20', 1, 0.0)
*/